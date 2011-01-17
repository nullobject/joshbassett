---
title: Test Article
kind: article
created_at: 2011-01-14
---
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisi orci, accumsan sit amet feugiat sit amet, cursus et eros. Maecenas tempus lobortis laoreet. Vivamus iaculis nulla et purus eleifend vitae suscipit magna iaculis. Vivamus tincidunt accumsan augue, et faucibus mauris commodo quis. Quisque eget arcu quam. Donec nec erat urna, nec viverra est. Fusce eget elit quis sem vulputate elementum tincidunt quis erat. Morbi pulvinar metus sed justo lacinia convallis accumsan lorem consectetur. Proin interdum euismod tempus. Nunc ultrices, odio sed scelerisque ultrices, dui justo bibendum diam, nec aliquet nunc augue in felis. Pellentesque ut ipsum at elit tempor tincidunt. Aliquam eu leo vel ipsum eleifend tristique nec eget est. Duis sed volutpat lorem. Vivamus adipiscing sodales est, pharetra porta nisi aliquet at. Praesent luctus semper interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit.

    @language-ruby

    Compass.add_project_configuration('config/compass.rb')

    compile '/stylesheets/*/' do
      filter :sass, Compass.sass_engine_options
    end

    compile %r(^/(images|javascripts)/.*/$) do
      # Don't filter or layout.
    end

    compile '/*/' do
      filter :bluecloth
      layout 'default'
    end

    compile '*' do
      filter :erb
      layout 'default'
    end

    route '/stylesheets/_*/' do
      # Don't route partials.
    end

    route '/stylesheets/*/' do
      item.identifier.chop + '.css'
    end

    route %r(^/(images|javascripts)/.*/$) do
      item.identifier.chop + "." + item[:extension]
    end

    route '*' do
      item.identifier + 'index.html'
    end

    layout '*', :erb

Fusce pellentesque semper porttitor. Fusce in massa enim, sit amet sollicitudin nisi. Maecenas ultricies dictum rhoncus. In hac habitasse platea dictumst. Mauris nec arcu lorem, blandit interdum sapien. Sed a justo elit. Pellentesque aliquet, arcu vel sodales cursus, diam diam tempus augue, ac aliquam nunc lectus a nulla. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean a ante eu lacus adipiscing dapibus. Etiam elementum nisl et ligula eleifend at ornare nunc venenatis. Phasellus ut ligula est. Phasellus semper, mi sed iaculis bibendum, dolor enim scelerisque diam, consectetur ultricies diam erat eu dui. Sed sit amet massa ipsum, aliquet consectetur erat. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nunc a diam ut diam congue porttitor. Integer congue ornare ligula ut blandit. In auctor nunc ac magna eleifend luctus.

Sed eget sem nec libero pretium vestibulum. Phasellus nisl velit, ullamcorper elementum sagittis eu, porttitor in ligula. Sed eget dolor sed turpis porttitor tristique. Morbi porta, augue in rutrum congue, sem nibh rhoncus metus, sagittis imperdiet erat libero sit amet nisl. Quisque ut consequat justo. Etiam blandit sollicitudin massa sit amet fermentum. Vestibulum at quam at ligula tristique elementum. Maecenas eget convallis risus. Nulla tristique, felis a pulvinar aliquet, magna orci faucibus ante, ut vulputate felis erat non metus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus in ligula sit amet eros pretium egestas in id nunc. Curabitur volutpat rhoncus neque non condimentum. Donec neque lorem, rhoncus ut congue sed, lacinia vitae mauris.

Vivamus sodales iaculis ligula, id mattis mauris elementum et. Nulla congue feugiat odio ac aliquam. Ut nec massa sit amet nibh faucibus eleifend. Aenean tristique mi nec massa hendrerit ac molestie enim ullamcorper. Morbi placerat leo convallis risus hendrerit a molestie purus varius. Mauris sodales sagittis luctus. Etiam aliquet laoreet leo et euismod. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin ornare nibh quis tortor condimentum a tincidunt justo malesuada. Suspendisse molestie tortor sit amet nulla ornare condimentum.

Nullam ornare lacinia tellus in commodo. Sed porta est non libero varius ut porttitor lorem posuere. Proin aliquet elit nec ante consequat at posuere diam viverra. In hac habitasse platea dictumst. Nam pretium pharetra lectus, vel aliquet lacus lacinia quis. Proin bibendum lacinia vulputate. Etiam vel lacus at eros varius dapibus. Donec tincidunt velit nec elit semper sit amet feugiat arcu interdum. Mauris vitae urna quis elit dignissim mollis. Suspendisse mollis varius mauris, at fringilla enim mattis commodo. Etiam porttitor mattis massa, vel bibendum urna blandit eu.
