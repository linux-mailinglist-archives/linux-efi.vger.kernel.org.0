Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6EA28E5CC
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgJNR60 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 13:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgJNR60 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 14 Oct 2020 13:58:26 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FBE42222C
        for <linux-efi@vger.kernel.org>; Wed, 14 Oct 2020 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602698305;
        bh=HxouAi1ZmuSmZs7OTUCCePGDaL8WxVjVuKNwxd5G+wY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wNB3QR7iH8Xi5UPXs5N0NINLOVigI5tsQT7mo/oomnLShXrkxJsxwWnpqfzoEbgI9
         j97pupI/CRbnaTC62WrK4MxA7MNqpv1LEfUgxO/VFNIa9riX2glNtC3VLHHcNjnM9l
         USd2RehzYTJXZewHFT8YKajjn2uzNmQRReJNGZpw=
Received: by mail-oi1-f180.google.com with SMTP id h10so107343oie.5
        for <linux-efi@vger.kernel.org>; Wed, 14 Oct 2020 10:58:25 -0700 (PDT)
X-Gm-Message-State: AOAM5316PzQwKbFAGM9MmRWHgFoSaB+awoV4fkMTXOQIm6LE/2eSOGfk
        VNSy6iIdeLJl6zO5pwSCC62MuakXSy7RQgZX8VE=
X-Google-Smtp-Source: ABdhPJzh079g1me8loeTZfw0+OTERvLuiFtcwaiFotM9m1fm1vNGbhQOqras/kSUlGiGkvkX+qjHBKlTKY0UXdrndbI=
X-Received: by 2002:aca:4085:: with SMTP id n127mr341222oia.33.1602698304554;
 Wed, 14 Oct 2020 10:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <4898db16-7f9b-2efc-a5ae-356461d790b8@gmx.de> <4b74c0b7-7126-2829-29d3-ef5131c52b73@gmx.de>
In-Reply-To: <4b74c0b7-7126-2829-29d3-ef5131c52b73@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 14 Oct 2020 19:58:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEy+SdBL2RbnF393scsOSGS-ACJX4QFuie-=HY99TpYRA@mail.gmail.com>
Message-ID: <CAMj1kXEy+SdBL2RbnF393scsOSGS-ACJX4QFuie-=HY99TpYRA@mail.gmail.com>
Subject: Re: fwts: RuntimeServicesSupported variable
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 14 Oct 2020 at 19:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 14.10.20 19:31, Heinrich Schuchardt wrote:
> > Dear all,
> >
> > the fwts fails on U-Boot due to testing for a non-existent
> > RuntimeServicesSupported variable.
> >
> > If you look at the UEFI specification 2.8 (Errata B) [1] you will
> > discover in the change log:
> >
> > 2.8 A2049
> > RuntimeServicesSupported EFI variable should be a config table
> > February 2020
> >
> > Please, read the configuration table to determine if a runtime service
> > is available on UEFI 2.8 systems.
> >
> > On lower UEFI firmware version neither the variable nor the table exists.
> >
> > Best regards
> >
> > Heinrich
> >
> > [1] UEFI Specification Version 2.8 (Errata B) (released June 2020),
> > https://uefi.org/sites/default/files/resources/UEFI%20Spec%202.8B%20May%202020.pdf
> >
>
> Hello Ard,
>
> what is your idea how the EFI_RT_PROPERTIES_TABLE shall be exposed to
> the efi_test driver?
>
> Will the EFI runtime wrapper simply return EFI_UNSUPPORTED if the
> function is not marked as supported in the table? Or will the
> configuration table itself be make available?
>

The UEFI spec permits that runtime services return EFI_UNSUPPORTED at
runtime, but requires that they are marked as such in the
EFI_RT_PROPERTIES_TABLE.

So assuming that the purpose of efi_test is compliance with the spec,
it should only allow EFI_UNSUPPORTED as a return value for each of the
tested runtime services if it is omitted from
efi.runtime_supported_mask.

Since the efi_test ioctl returns both an error code and the actual EFI
status code, we should only fail the call on a EFI_UNSUPPORTED status
code if the RTPROP mask does not allow that.

E.g.,

--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -265,7 +265,12 @@ static long efi_runtime_set_variable(unsigned long arg)
                goto out;
        }

-       rv = status == EFI_SUCCESS ? 0 : -EINVAL;
+       if (status == EFI_SUCCESS ||
+           (status == EFI_UNSUPPORTED &&
+            !efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)))
+               rv = 0;
+       else
+               rv = -EINVAL;

 out:
        kfree(data);


Do you think that could work?
