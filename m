Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F49A37BDFE
	for <lists+linux-efi@lfdr.de>; Wed, 12 May 2021 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhELNVA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 09:21:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38248 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231233AbhELNU7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 09:20:59 -0400
Received: from zn.tnic (p200300ec2f0bb8006edd94bc9370939d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b800:6edd:94bc:9370:939d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C6A11EC0390;
        Wed, 12 May 2021 15:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620825590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oNPg3vxOc+Ox+fohCHc47ZdZvfnk6G6W8tH14loE6Sk=;
        b=EXX3oJI2tQjSdwnPllc9um9bPhyDf7PQfncbtmfHKP6Hrxdm55NHa0eq4ZTpq0cCGdkXP6
        c8mOCsVIbwB/YbmD9raGg/HlLIsfs6Wi1w8WtpfFG2+oQFpVT+E+eU+6lco8IOP94Dy/Ho
        uCHzu9WmRWphRwHgamwuBfED5dzVMgg=
Date:   Wed, 12 May 2021 15:19:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, joro@8bytes.org, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, seanjc@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 3/4] EFI: Introduce the new AMD Memory Encryption GUID.
Message-ID: <YJvV9yKclJWLppWU@zn.tnic>
References: <cover.1619193043.git.ashish.kalra@amd.com>
 <f9d22080293f24bd92684915fcee71a4974593a3.1619193043.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9d22080293f24bd92684915fcee71a4974593a3.1619193043.git.ashish.kalra@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 23, 2021 at 03:59:01PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Introduce a new AMD Memory Encryption GUID which is currently
> used for defining a new UEFI environment variable which indicates
> UEFI/OVMF support for the SEV live migration feature. This variable
> is setup when UEFI/OVMF detects host/hypervisor support for SEV
> live migration and later this variable is read by the kernel using
> EFI runtime services to verify if OVMF supports the live migration
> feature.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  include/linux/efi.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 8710f5710c1d..e95c144d1d02 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -360,6 +360,7 @@ void efi_native_runtime_setup(void);
>  
>  /* OEM GUIDs */
>  #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> +#define MEM_ENCRYPT_GUID			EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
>  
>  typedef struct {
>  	efi_guid_t guid;
> -- 

When you apply this patch locally, you do:

$ git log -p -1 | ./scripts/get_maintainer.pl
Ard Biesheuvel <ardb@kernel.org> (maintainer:EXTENSIBLE FIRMWARE INTERFACE (EFI))
linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))
linux-kernel@vger.kernel.org (open list)

and this tells you that you need to CC EFI folks too.

I've CCed linux-efi now - please make sure you use that script to CC the
relevant parties on patches, in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
