Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C4748EEE
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jul 2023 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjGEU06 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jul 2023 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjGEU0z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jul 2023 16:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8237198E
        for <linux-efi@vger.kernel.org>; Wed,  5 Jul 2023 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688588765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t45r9A2YvfoSJv2GZo8UC8AtO/lxGa/2A2TsFaxOzFQ=;
        b=emWGxfyrkx50WcIpqLScygToO5DkWvh+JUB/5h5F7AOqQu8xOLYxxUHhshrQ6cltN3TYpK
        csrse0jVgdtDKhzp7PafgjCce61eL+KeIrAi+gjvzbg2uqBUFILYLrWXJTM5uVlzKS5u9b
        mxIE3+FDDbTQvHNSrPOSRXyde7skQsQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-RNYlkttuO_u6E8D4oZQQFA-1; Wed, 05 Jul 2023 16:26:04 -0400
X-MC-Unique: RNYlkttuO_u6E8D4oZQQFA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-262e619fb5aso82805a91.2
        for <linux-efi@vger.kernel.org>; Wed, 05 Jul 2023 13:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688588764; x=1691180764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t45r9A2YvfoSJv2GZo8UC8AtO/lxGa/2A2TsFaxOzFQ=;
        b=EnR3cZbaTFh/7j3oT5obJe6iNc81CNHiUpL1TVAfX8ZBhyuSlVLLYBFItDyYueZf1W
         EEX0cWUxtwV41HFIrG40bTOm6NxVcLRbhZ9hcxQAQF51t6R3a2e/1HyGw6hTcQBDbDcJ
         kqqVtbI8y+k84k9+b75fLZnd7OvEma7jG9y2SvXnI7Tq5t5Svl2xdueDf+YiLoOEjANN
         CbxZ3eWtb7FAYTno5MsvJSpcgJWu1fIrC6Ceg+g6uVDZ6uO4nU94AEqiivTr7IHNDlzX
         2USP2mYJv+EZaxuwryvmY3sGFBJeNSIdZOYaPedyMcQTI9tXQvzfnNXfGcrIoY4MW56N
         omuA==
X-Gm-Message-State: AC+VfDyO6n6UzD+kG9m8JwKWYB0twst+VpblKlHOa8jK6lWAY9AjXNqI
        vjVvXXPUpIKSHQtc4okzLl4dV1NM6cNmGBD7Q0dtqzPbB9Q96Z+NB7pjXlOHhdDxFobOiHTMs76
        q/g/O6JlXEsvAIhwnhAlsKk93uDyZ4zj7AsXQ
X-Received: by 2002:a05:6a21:6d88:b0:122:e4f:25c7 with SMTP id wl8-20020a056a216d8800b001220e4f25c7mr15659562pzb.31.1688588763759;
        Wed, 05 Jul 2023 13:26:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ds4xvbUG+ZYaDvJ2apGx91OQ4qB0akGNWWFL3LaWKhMz96IxFpmQ2sEuPoCI3p2ih7fuYhkf9fNjQ5oeaAq0=
X-Received: by 2002:a05:6a21:6d88:b0:122:e4f:25c7 with SMTP id
 wl8-20020a056a216d8800b001220e4f25c7mr15659535pzb.31.1688588763446; Wed, 05
 Jul 2023 13:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230609125023.399942-1-jlayton@kernel.org> <20230609125023.399942-8-jlayton@kernel.org>
 <CAHc6FU4wyfQT7T75j2Sd9WNp=ag7hpDZGYkR=m73h2nOaH+AqQ@mail.gmail.com> <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
In-Reply-To: <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 5 Jul 2023 22:25:51 +0200
Message-ID: <CAHc6FU54Gh+5hovqXZZSADqym=VCMis-EH9sKhAjgjXD6MUtqw@mail.gmail.com>
Subject: Re: [PATCH 7/9] gfs2: update ctime when quota is updated
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 12, 2023 at 12:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> On Fri, 2023-06-09 at 18:44 +0200, Andreas Gruenbacher wrote:
> > Jeff,
> >
> > On Fri, Jun 9, 2023 at 2:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/gfs2/quota.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> > > index 1ed17226d9ed..6d283e071b90 100644
> > > --- a/fs/gfs2/quota.c
> > > +++ b/fs/gfs2/quota.c
> > > @@ -869,7 +869,7 @@ static int gfs2_adjust_quota(struct gfs2_inode *i=
p, loff_t loc,
> > >                 size =3D loc + sizeof(struct gfs2_quota);
> > >                 if (size > inode->i_size)
> > >                         i_size_write(inode, size);
> > > -               inode->i_mtime =3D inode->i_atime =3D current_time(in=
ode);
> > > +               inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =
=3D current_time(inode);
> >
> > I don't think we need to worry about the ctime of the quota inode as
> > that inode is internal to the filesystem only.
> >
>
> Thanks Andreas.  I'll plan to drop this patch from the series for now.
>
> Does updating the mtime and atime here serve any purpose, or should
> those also be removed? If you plan to keep the a/mtime updates then I'd
> still suggest updating the ctime for consistency's sake. It shouldn't
> cost anything extra to do so since you're dirtying the inode below
> anyway.

Yes, good point actually, we should keep things consistent for simplicity.

Would you add this back in if you do another posting?

Thanks,
Andreas

> Thanks!
>
> > >                 mark_inode_dirty(inode);
> > >                 set_bit(QDF_REFRESH, &qd->qd_flags);
> > >         }
> > > --
> > > 2.40.1
> > >
> >
> > Thanks,
> > Andreas
> >
>
> --
> Jeff Layton <jlayton@kernel.org>
>

