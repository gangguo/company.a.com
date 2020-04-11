<{include file="./public/header.tpl" }>
<link href="static/<{$_template}>css/galleryeffect.css" rel="stylesheet" type="text/css" media="all" />


<div class="container">
    <div class="page">
        <div class="grid_3 grid_4">
            <div class="page-header">
                <h4><{$data.title}></h4>
            </div>

              <div class="bs-example">
                <table class="table">
                  <tbody>
                    <tr>
                      <td>
                        <h5 id="h5-bootstrap-heading"><img src="<{$data.show_cover_img}>"></h5>
                      </td>
                    </tr>
                    <tr>
                       <td class="type-info"><{$data.show_price}></td>
                    </tr>
                    <tr>
                       <td class="type-info"><{$data.intro}></td>
                    </tr>
                  </tbody>
                </table>
              </div>
        </div>
    </div>
</div>

<!-- //gallery -->


<{include file="./public/footer.tpl" }>
