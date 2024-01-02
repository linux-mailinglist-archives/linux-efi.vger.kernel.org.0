Return-Path: <linux-efi+bounces-295-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FBD821F77
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 17:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FBE1F229E1
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2314F6D;
	Tue,  2 Jan 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExYyGdi1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F114F63;
	Tue,  2 Jan 2024 16:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50104C433CA;
	Tue,  2 Jan 2024 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704212831;
	bh=eFEd7K66r3sAQkzNrfgd/oQ52+Ogas6L7kNAjyIMi68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ExYyGdi1rgkLxP0zOa9Dur7M7hl15KQDis1p1r8HxGzY8mGtO7fFjYrHGrW4giDwe
	 WnRiMaQ3B7/Fp46FL4lwfbg1QyoSExZ32pEnlIvwaLCs8ghu3K0wac9CaB0RJVdvzO
	 1LRJYQpDcMjmvs6Bo4oIXqM8KRF3b6Qb2Otsq4kMKBBFEHUzTekS2xAVXnPVU7Hwzh
	 Bz+svjbY0yoWW17SE2Isbo4NH/xmR+Ldpcw21vnaovAepBDX5aQCR9LSCaVCICU/fn
	 vV07g1uvE++NSKQprTssI1MNPJngoLARbTK5S4bl8s0yl7d43dnFS76qJT33c+2Ab+
	 ApS3CGDWvdA6g==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e7ddd999bso6555137e87.1;
        Tue, 02 Jan 2024 08:27:11 -0800 (PST)
X-Gm-Message-State: AOJu0YxIo2WvvZQbTm+mZHTGUViB2MkCGemNFoD1uwrGdxDNcnITqVkM
	DPnf6rmetddH+Si/RmJdFujZXFaB3RhpiQVhtCc=
X-Google-Smtp-Source: AGHT+IEJFD5L2vHU4Bpgh0Mhvng3XMQQ7+NDrmu+eS+oOFVstLIP2nWMtW45itgfwzNClv//C0Wx+/evRescYN5k2Hk=
X-Received: by 2002:a05:6512:159c:b0:50e:7c6e:b411 with SMTP id
 bp28-20020a056512159c00b0050e7c6eb411mr7629688lfb.103.1704212829567; Tue, 02
 Jan 2024 08:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226140250.224516-1-ytcoode@gmail.com> <CAMj1kXGE9JUoPUqBMJkwVUco67dEa8N95=gMJwE+Sj1ux1+5tQ@mail.gmail.com>
 <b2c4835d-0076-47f0-b0d1-792dc32cc305@amd.com>
In-Reply-To: <b2c4835d-0076-47f0-b0d1-792dc32cc305@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Jan 2024 17:26:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXELiSzz75EGJuYwvSURfjGmZaRLEQghvGVVc5JMN+Npow@mail.gmail.com>
Message-ID: <CAMj1kXELiSzz75EGJuYwvSURfjGmZaRLEQghvGVVc5JMN+Npow@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Yuntao Wang <ytcoode@gmail.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Glaze <dionnaglaze@google.com>, Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jan 2024 at 17:26, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 1/2/24 09:29, Ard Biesheuvel wrote:
> > On Tue, 26 Dec 2023 at 15:03, Yuntao Wang <ytcoode@gmail.com> wrote:
> >>
> >> When KASLR is enabled, the KASLR_FLAG bit in boot_params->hdr.loadflags
> >> should be set to 1 to propagate KASLR status from compressed kernel to
> >> kernel, just as the choose_random_location() function does.
> >>
> >> Currently, when kernel is booted via efi stub, the KASLR_FLAG bit in
> >> boot_params->hdr.loadflags is not set, even though it should be. This
> >> causes some functions, such as kernel_randomize_memory(), not to execute
> >> as expected. Fix it.
> >>
> >> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> >> ---
> >>   drivers/firmware/efi/libstub/x86-stub.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> >> index da9b7b8d0716..b0c68593ad40 100644
> >> --- a/drivers/firmware/efi/libstub/x86-stub.c
> >> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> >> @@ -787,7 +787,10 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
> >>                          efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
> >>                          seed[0] = 0;
> >>                  }
> >> -       }
> >> +
> >> +               boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
> >> +       } else
> >> +               boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
> >>
> >
> > Thanks for the fix.
>
> Does it need a Fixes: tag?
>

Yes, I've added that.

