Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF73A2EE7
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jun 2021 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhFJPEG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Jun 2021 11:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhFJPEC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Jun 2021 11:04:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D475613E9;
        Thu, 10 Jun 2021 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623337326;
        bh=p+H8s0egdv3BGUJk4DbOgLzpOhw4FBnL6dPXfrgDCc0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cq8/V0Fpo8XOlZkPj+d/rVs3in/wDRFomFDz6ZeoQWR6G4Ok3yX5uSFkxuNU02eBb
         PZwLF0VzB7opk+RJs51k4s1BH47qvnTYO9CHvm6w/IK63s/ugXRl3kdBR72Ej5gd3d
         uhQXpRTdpuIdSbWl8rydlMOWYvGtl97ngU7HfU6yfm3Xr4xoEpalr5jrEzD9YVCqB9
         5J50D2D20P37Ki3WNZDt/eGXVpE9z9hzzNZQJpT/l3lILuqoJBUhhLkp2qM4jecyDA
         IC4Cav5iNZzrMdBwAcpIOJnWguN+7OdshvXSaJ2rpmbzk/gRS4XJvrMIA086TQTw4X
         SlLpfIciQZ1ow==
Received: by mail-oi1-f175.google.com with SMTP id z3so2420686oib.5;
        Thu, 10 Jun 2021 08:02:06 -0700 (PDT)
X-Gm-Message-State: AOAM533LnU/FxMm4phO3JehjJfAGkZPPq2juz10fK7/LIlRDV3wG21Vi
        uQkSFmYBJiCIJoPjHw1kAZD3ejKYq8TonKyN80A=
X-Google-Smtp-Source: ABdhPJzwc9dtTqV4JuYFW4MyFIjIJUhIi1DCsWgsdHf5pQ3cE8Zc4m+2QBQ9n5BXeIej8L3/LPhxI861X/0qqbQMsWI=
X-Received: by 2002:a54:460a:: with SMTP id p10mr10583973oip.47.1623337325826;
 Thu, 10 Jun 2021 08:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623174621.git.ashish.kalra@amd.com> <13d4bdd5fc0cf9aa0ad81d43da975deb37f0d39c.1623174621.git.ashish.kalra@amd.com>
In-Reply-To: <13d4bdd5fc0cf9aa0ad81d43da975deb37f0d39c.1623174621.git.ashish.kalra@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Jun 2021 17:01:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGOaTR6bCHYtdapgM4wfzNTFQ5f-n5Jf0q28JEmsKimZw@mail.gmail.com>
Message-ID: <CAMj1kXGOaTR6bCHYtdapgM4wfzNTFQ5f-n5Jf0q28JEmsKimZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] EFI: Introduce the new AMD Memory Encryption GUID.
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        X86 ML <x86@kernel.org>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Rutherford <srutherford@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 8 Jun 2021 at 20:07, Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
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

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  include/linux/efi.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6b5d36babfcc..dbd39b20e034 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -362,6 +362,7 @@ void efi_native_runtime_setup(void);
>
>  /* OEM GUIDs */
>  #define DELLEMC_EFI_RCI2_TABLE_GUID            EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> +#define AMD_SEV_MEM_ENCRYPT_GUID               EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
>
>  typedef struct {
>         efi_guid_t guid;
> --
> 2.17.1
>
