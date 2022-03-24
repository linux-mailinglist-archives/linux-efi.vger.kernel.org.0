Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5E4E6306
	for <lists+linux-efi@lfdr.de>; Thu, 24 Mar 2022 13:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349976AbiCXMSP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Mar 2022 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349981AbiCXMSN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Mar 2022 08:18:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2692699EE3
        for <linux-efi@vger.kernel.org>; Thu, 24 Mar 2022 05:16:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bc27so3684768pgb.4
        for <linux-efi@vger.kernel.org>; Thu, 24 Mar 2022 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VsMoQ6a5yHypTrD9qrKDAaRCbFUvI6woBhxzZufr/gQ=;
        b=QeMdmwBAlF5KAuarUQclZ5ZRvKv4i2+eqIGN32O/mxGN1JFuvF6NKTCjK8FPf1WzMe
         Ccoj0wKaHA5Tn0fyll0sjCTzlYSuUdlO5uggegLDtuEfNtbXmobAT3+sR4HNGn0SWb/s
         VdjvJS6kwWytLJP7tdHxrKw/myZYZkoeK926dU1WWAQX3n8/iw3Cbes5lTqO9ThGYFFZ
         kpZVgIcbn1l63M72c1q7L3wl3w/T9zCXvdchwpllRy5JRRWP+CT9fdiQ54Fzr+pSiCBh
         f0hL/WBAb6KslNlK5zbMIvWDia6Xq70KlyN8M3A9/PCD215Fqdajzgxaq8jf/3PpUZxZ
         QUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VsMoQ6a5yHypTrD9qrKDAaRCbFUvI6woBhxzZufr/gQ=;
        b=eTF9+ZQsdnvxBcaz9mQhknG1mpCvkPJ8sXAwUjwrGZvaglL1lo+4LJS8xr3KqocMqW
         Id3fHKAkPWlHCaSFQe+HjUcHX/M/x4eKyn8xyHDqAXBtDOrIBo5F7uS0GJk4JQlnSyx/
         zN8ixXfIqB4DPNe02E2CJbjaAEcltjyqRGoijAl+u/Ov/IUkxIExyOkzoJaefVXLJ6jw
         JkKVUCAFYpfq7paE+KNCyYTXJ3RTN7tJQzr8W9wfAbhLinXIQ+fayWtQZtFLjxHp1Qnn
         7NoWGYb+mFiAPc9Xn156wb0YBhIcvwsDZMSwrSD6yc3mzdfM14UytKxwL9uROa1WwHpQ
         RlvQ==
X-Gm-Message-State: AOAM532Na93R7CfcYexZjLJWSQRIsAELE5FXPkKI3C2wKNkDIFkj6ig2
        fofDzXxw67GzkDEh1NJZPrGrfw==
X-Google-Smtp-Source: ABdhPJypoVx1bf/+/f0PU9KTcPgh58skt21jmyiixnpzbP1eozq/x0NuCqhl1yY7OBtxWORA63nZDQ==
X-Received: by 2002:a63:1f55:0:b0:382:65eb:3073 with SMTP id q21-20020a631f55000000b0038265eb3073mr3839199pgm.624.1648124201594;
        Thu, 24 Mar 2022 05:16:41 -0700 (PDT)
Received: from sunil-laptop ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id s30-20020a056a001c5e00b004f75773f3fcsm3295399pfw.119.2022.03.24.05.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:16:41 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:46:31 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Abner Chang <abner.chang@hpe.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 1/1] riscv/efi_stub: Add support for
 RISCV_EFI_BOOT_PROTOCOL
Message-ID: <20220324121631.GA39769@sunil-laptop>
References: <20220324112534.209959-1-sunilvl@ventanamicro.com>
 <20220324112534.209959-2-sunilvl@ventanamicro.com>
 <14f87d29-ebc9-51a3-020c-353878bcb1ba@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f87d29-ebc9-51a3-020c-353878bcb1ba@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 24, 2022 at 12:46:12PM +0100, Heinrich Schuchardt wrote:
> On 3/24/22 12:25, Sunil V L wrote:
> > This patch adds the support for getting the boot hart ID in
> > Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL. This protocol
> > is preferred method over existing DT based solution since it
> > works irrespective of DT or ACPI.
> > 
> > The specification of the protocol is hosted at:
> > https://github.com/riscv-non-isa/riscv-uefi
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> This seems to be v3 of the patch. v2 is available in
> https://lore.kernel.org/all/20220303145944.307321-2-sunilvl@ventanamicro.com/
> 
> v3 replaces a message in efi_status_t check_platform_features():
> 
> <+   efi_err("/chosen/boot-hartid missing or invalid!\n");
> >+   efi_err("Failed to get boot hartid!\n");

Yes, that's correct. Sorry I missed the version. I resent the patch with
version and your RB tag added.

Thanks!
Sunil
> 
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> > ---
> >   drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
> >   drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
> >   include/linux/efi.h                       |  1 +
> >   3 files changed, 32 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index edb77b0621ea..aced62a0907e 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -720,6 +720,13 @@ union efi_tcg2_protocol {
> >   	} mixed_mode;
> >   };
> > +struct riscv_efi_boot_protocol {
> > +	u64 revision;
> > +
> > +	efi_status_t (__efiapi * get_boot_hartid)(struct riscv_efi_boot_protocol *this,
> > +						  size_t *boot_hartid);
> > +};
> > +
> >   typedef union efi_load_file_protocol efi_load_file_protocol_t;
> >   typedef union efi_load_file_protocol efi_load_file2_protocol_t;
> > diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> > index 9c460843442f..012504f6f9a4 100644
> > --- a/drivers/firmware/efi/libstub/riscv-stub.c
> > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > @@ -23,7 +23,7 @@
> >   typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
> > -static u32 hartid;
> > +static size_t hartid;
> >   static int get_boot_hartid_from_fdt(void)
> >   {
> > @@ -47,14 +47,33 @@ static int get_boot_hartid_from_fdt(void)
> >   	return 0;
> >   }
> > +static efi_status_t get_boot_hartid_from_efi(void)
> > +{
> > +	efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
> > +	efi_status_t status;
> > +	struct riscv_efi_boot_protocol *boot_protocol;
> > +
> > +	status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
> > +			     (void **)&boot_protocol);
> > +	if (status == EFI_SUCCESS) {
> > +		status = efi_call_proto(boot_protocol,
> > +					get_boot_hartid, &hartid);
> > +	}
> > +	return status;
> > +}
> > +
> >   efi_status_t check_platform_features(void)
> >   {
> >   	int ret;
> > +	efi_status_t status;
> > -	ret = get_boot_hartid_from_fdt();
> > -	if (ret) {
> > -		efi_err("/chosen/boot-hartid missing or invalid!\n");
> > -		return EFI_UNSUPPORTED;
> > +	status = get_boot_hartid_from_efi();
> > +	if (status != EFI_SUCCESS) {
> > +		ret = get_boot_hartid_from_fdt();
> > +		if (ret) {
> > +			efi_err("Failed to get boot hartid!\n");
> > +			return EFI_UNSUPPORTED;
> > +		}
> >   	}
> >   	return EFI_SUCCESS;
> >   }
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index ccd4d3f91c98..9822c730207c 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -380,6 +380,7 @@ void efi_native_runtime_setup(void);
> >   #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
> >   #define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
> >   #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
> > +#define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
> >   #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> >   #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
> >   #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
> 
