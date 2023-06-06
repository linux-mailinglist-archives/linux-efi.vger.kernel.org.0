Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05684724A7F
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 19:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbjFFRp7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjFFRp7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 13:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5AB1715
        for <linux-efi@vger.kernel.org>; Tue,  6 Jun 2023 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686073513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLE2a9m2X7ys1i2tOPH+yWFEAQ0wlkVtQl8hZ5lZPhc=;
        b=RS681NVj2YiiMPHFR1cnPOcB5IW3ZBiWMfUxAKIwm3wT6NlrXJNWi8JrjPcPzTuAspBruH
        RRpoLF3ehKbtqOI6eytyh0xLq1gzRs8APPUICLk6VUz07fl/pVFR7GEJFWM3XXvY4GGPgz
        UG0Z/zyNJgZJsI75tzgu/p02beBBdVo=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-75ZPBB1JPS2vZebS8qZLug-1; Tue, 06 Jun 2023 13:45:12 -0400
X-MC-Unique: 75ZPBB1JPS2vZebS8qZLug-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-78a259edb5aso1085106241.2
        for <linux-efi@vger.kernel.org>; Tue, 06 Jun 2023 10:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686073512; x=1688665512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLE2a9m2X7ys1i2tOPH+yWFEAQ0wlkVtQl8hZ5lZPhc=;
        b=WsSKzzTY/0HJBIdgob0fu6CaGJbcN3a1uz5GZlZeKlVqaF9mYWkiAYwT9RgnGVabu+
         kiEjKSsAWDLOXT0eGdSBbQDJ0c8plt03/q+8FCAl3EgGmndGGEXY9vCDGmquOpGR0nvK
         +9KYq3vEYEtpbDWLX+xD4vn/WdsCdYvnK9yLFb/aXs0c1oKV5sJYiT65ixS1NKYvJTno
         xY+OFiS40woHL8MS8NfXGttfqu2H6taz7m2UQiM6ADjo9vr2Kfty9NAWcnRTlZfB8axx
         rGzl7ZeOhDA238nlRRj2U/zFP+ekotoUg/1jND61kJUaymU3XDXcftC2t+PhOZ0tlkHO
         x65w==
X-Gm-Message-State: AC+VfDySVe4b51ZrQ0wqst2ZJDn4AsVQ5bFQtvhqVfsJzx7pgZ4avEF+
        tR3gUhcQd0fwUMLRCym85hzUt5DMOk7WsUjBGUXAzZCVIiaB8Xz5vUlszGf4f9yc72ur09HP0Hk
        jnRPmjRdVfM4MvYzGfDVLoWqOJZZJnglXA6fkZaIkxTOoEn0=
X-Received: by 2002:a67:cd1a:0:b0:437:e5ce:7e8f with SMTP id u26-20020a67cd1a000000b00437e5ce7e8fmr264395vsl.4.1686073511871;
        Tue, 06 Jun 2023 10:45:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ510EGPnb1pvusV1Awai+/0gM7p797ZiE7obJT6qHBhuOLM8zytgZq1baKHREg+V5zuAqlHw8q/hrA9acpoTRw=
X-Received: by 2002:a67:cd1a:0:b0:437:e5ce:7e8f with SMTP id
 u26-20020a67cd1a000000b00437e5ce7e8fmr264386vsl.4.1686073511556; Tue, 06 Jun
 2023 10:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230512194302.1662230-1-nicholasbishop@google.com> <CAMj1kXERDgT1cM-2P4M=DBGU0Wzbc-zewGsJjLQoQHpC3ds-4g@mail.gmail.com>
In-Reply-To: <CAMj1kXERDgT1cM-2P4M=DBGU0Wzbc-zewGsJjLQoQHpC3ds-4g@mail.gmail.com>
From:   Peter Jones <pjones@redhat.com>
Date:   Tue, 6 Jun 2023 13:45:00 -0400
Message-ID: <CA+g+hrjBhOeAHiLU9i=hpfp-0S2wCr9VyNQRKSxMGrv+9GR=oQ@mail.gmail.com>
Subject: Re: [PATCH] efi/esrt: Allow ESRT access without CAP_SYS_ADMIN
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nicholas Bishop <nicholasbishop@google.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 22, 2023 at 4:11=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 12 May 2023 at 21:43, Nicholas Bishop <nicholasbishop@google.com>=
 wrote:
> >
> > Access to the files in /sys/firmware/efi/esrt has been restricted to
> > CAP_SYS_ADMIN since support for ESRT was added, but this seems overly
> > restrictive given that the files are read-only and just provide
> > information about UEFI firmware updates.
> >
> > Remove the CAP_SYS_ADMIN restriction so that a non-root process can rea=
d
> > the files, provided a suitably-privileged process changes the file
> > ownership first. The files are still read-only and still owned by root =
by
> > default.
> >
> > Signed-off-by: Nicholas Bishop <nicholasbishop@google.com>
>
> Seems reasonable to me. Peter?

Yeah, I don't think we had any specific reason to limit it.

-- Peter

