require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "se debe poder crear un post" do
    post = Post.create(title: "Mi titulo", content: "Mi contenido")
    assert post.save
  end

  test "se debe poder actualizar un post" do
    post = posts(:primer_articulo)
    assert post.update(title: "Nuevo titulo", content: "Nuevo contenido")
  end

  test "se debe poder encontrar un post por su id" do
    post_id = posts(:primer_articulo).id
    assert_nothing_raised { Post.find(post_id) }
  end

  test "se debe poder borrar un post" do
    post = posts(:primer_articulo)
    post.destroy
    assert_raise(ActiveRecord::RecordNotFound) {Post.find(post.id)}
  end

  test "no se debe poder crear un post sin titulo" do
    post = Post.new
    assert post.invalid?, "El post debería ser invalido"
  end

  test "cada titulo tiene que ser unico" do
    post = Post.new
    post.title = posts(:primer_articulo).title
    assert post.invalid?, "Dos posts no pueden tener el mismo titulo"
  end

end
