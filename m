Return-Path: <linux-efi+bounces-292-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCEF821EB5
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933761C223DB
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F4814293;
	Tue,  2 Jan 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGCJ7kdd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8E1428F;
	Tue,  2 Jan 2024 15:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC1BC433C8;
	Tue,  2 Jan 2024 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704209367;
	bh=d+GvaZhekVGQ9lMSiy4Nb4qHQGNOIjyRoiXkoMRn9yI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lGCJ7kddtHhcx8SjMavy1CSlW4RvUgR5Ap5KRjY/3PrAQ07ZQeaObkWbyw/PIbu3Z
	 86TH9bs/Vv43igh0SM2B0C8ApvsIMj/C7b5/IVBu4l0oAAB2g1osNbj3OeMx/ttu4z
	 vvnKpUDYB5i9jsKiPkIPZiBKs/E+7YYBC6heHmbY18zQqVex6Hmf0Kl9+7PK8QiT6f
	 eRrXEkV8AyWglf7vdOCK9xeV8dQncGcBoVs5g9/mO5RLGOv8rFPkutsLQ+pQMzNCRr
	 bl8++chHRO+TP4Rupo5jS0wTOCWrRa+2KPuCr9FlZZh2ydANnZbItI8o5sdt3UtfBQ
	 +tV6+06Ma097Q==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccb923c4d2so67810491fa.1;
        Tue, 02 Jan 2024 07:29:27 -0800 (PST)
X-Gm-Message-State: AOJu0Yzbnwo15zMMvb8YN9RZ6QQkbEGtEW1YnZUJCpvt19N9paA9UYe6
	IPNYmZLhr2FnDK4ps311vOSVbh2Nwz4uPKNZIrc=
X-Google-Smtp-Source: AGHT+IFkY96f+Fzyys0m5W4HejFsT7GIwVGOyenJCF6vEs7THGZZcIAqpDx+7TsODB0DRh5AoG0KVWWB4lb7+H3/DcI=
X-Received: by 2002:a05:6512:b23:b0:50e:8ccc:6dec with SMTP id
 w35-20020a0565120b2300b0050e8ccc6decmr2574561lfu.126.1704209366003; Tue, 02
 Jan 2024 07:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226140250.224516-1-ytcoode@gmail.com>
In-Reply-To: <20231226140250.224516-1-ytcoode@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Jan 2024 16:29:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGE9JUoPUqBMJkwVUco67dEa8N95=gMJwE+Sj1ux1+5tQ@mail.gmail.com>
Message-ID: <CAMj1kXGE9JUoPUqBMJkwVUco67dEa8N95=gMJwE+Sj1ux1+5tQ@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Glaze <dionnaglaze@google.com>, Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Dec 2023 at 15:03, Yuntao Wang <ytcoode@gmail.com> wrote:
>
> When KASLR is enabled, the KASLR_FLAG bit in boot_params->hdr.loadflags
> should be set to 1 to propagate KASLR status from compressed kernel to
> kernel, just as the choose_random_location() function does.
>
> Currently, when kernel is booted via efi stub, the KASLR_FLAG bit in
> boot_params->hdr.loadflags is not set, even though it should be. This
> causes some functions, such as kernel_randomize_memory(), not to execute
> as expected. Fix it.
>
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index da9b7b8d0716..b0c68593ad40 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -787,7 +787,10 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>                         efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
>                         seed[0] = 0;
>                 }
> -       }
> +
> +               boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
> +       } else
> +               boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
>

Thanks for the fix.

I'll queue this up right away, but I am going to drop the 'else' part,
given that the KASLR flag is never set by the EFI stub so clearing it
should never be needed.


>         status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
>                                   seed[0], EFI_LOADER_CODE,
> --
> 2.43.0
>

