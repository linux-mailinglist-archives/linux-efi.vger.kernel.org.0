Return-Path: <linux-efi+bounces-729-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BC887282C
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 21:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E6B1F2802C
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D71292F2;
	Tue,  5 Mar 2024 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/m2KvDV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F812880D
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668827; cv=none; b=sXKvByE2uKepU5cp2gsYT2YHn2fM37qX8Nt/7+/nDoJ72abxnoCspagDQpXW1gD4v32mafFXJC6ZnymtVsn+bx7qBidSOeO7cefQ+s6+NB/Ymduc+NSMCMZcpPoG2wsZ/lRWE4LJ3zopC/iRBdI4xtPwSaSzdXI1NzMMfsoIzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668827; c=relaxed/simple;
	bh=quTLs9D3TbNO9iQ+7WB9pmJA/w191Ftkzk9xC5g1RQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoW3BaWI0Q5owO3hqntoeuvpI5La3lvVTSc2Y++sl5GXpYxMVSa0pIBq9d/Gh825baZgNNvu6WFQRxhv5wJpFfr/fV8RrtbnlVVdsXtIwpAymkJN5w+x5XqSokHsv5ImekafAUXYk7xjfqu1HO4NCk1NCvbnokto6Au64iRMT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/m2KvDV; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so6252996e87.0
        for <linux-efi@vger.kernel.org>; Tue, 05 Mar 2024 12:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709668822; x=1710273622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PV8o2uuEF/pCmcS326NuqgK+cgZbeIi3U71MGj5DcA8=;
        b=K/m2KvDVhPb0JRkjmGLmCmn3fPCnZbGmz4M4VrlLUFCZHNCBRDPgNgZ2TVzcykb+vA
         dd0zFyjUZYSmOJlU+yN7tw2kR6G1Mre9e+HDXXgXCKH3bQbqlEAPxiLTgOonsOi6FmKp
         fpKC91NIoNYNvHljPLYvLI4sx6YEfh3UP8XdfPxT5KZU/0ZUBedoNxnFPIYOUxdK592F
         2veSP6IqplyYmGxmC5BmyCdhWGVCN7ChFIa0IKexW4pO7rzBaMxGZ7bLiJi+WVMdf1ws
         RMq/asVNfmO33pEGXvQhIJzGZ1rgSS0LeD4cMe4qjnMKSTQOXdPC6g5+AWlBwFI+x2So
         IIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668822; x=1710273622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PV8o2uuEF/pCmcS326NuqgK+cgZbeIi3U71MGj5DcA8=;
        b=pgNZYUrcgm6E7FLFDI7Xu5fQimcnGGYoDfGfwLPudx1G9KyMAiUV/YQbr1TQ94YKxE
         0x5lLNpYIu23vxAx2ZCc9tUCHJKw69vew2C3bGc0CtHN9NreiBUWDoqYQVbqIDymSXnJ
         cnee1qs5ufcrjSCe0nJx5+o5784Ii6UG35eYnQS7hVvGEidyYjeMSpIgwfJgkSy5/wmy
         nLJ3SoGaHmvQvkzTyRTULmLxS866jaUbX+q/KXYsvetNZnm05i5U2yAgJgBuu+6eeFwM
         6PGiNwM3DTtBfzCJIwCLy9xPOckVPu1+OlpxYYPqx9eUhG4/lrAyywcrmqZShbjJ+JGO
         sGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8AzdAvDcX/aEJql5pRHPIRo83u0ba3LHG9gaq6bHORJnh/gNIV87Q0UMTYZDCQgOqvDN0SX6Kalk7XbgtnsW5noT4J7brfzlB
X-Gm-Message-State: AOJu0YwdRT6K90N9qjapGy6VtMxgIweFelO7ePrFDfwMPgeYkfkkiSjB
	6LkrJvYoa5RL1ucBAD9CdWn+V049IkpouAMBz2KpLpGdVFBY8Ad7ZExM3wwIbRnMTZxd3tWjEeV
	TkwIG6cjlDhiGNcoB7byqEGvGjeeYBXSMJbJnZ1o8qajFFFJFXOFhdA==
X-Google-Smtp-Source: AGHT+IGK1Ee1GrFknsZjX+sKtm2gDs28IN37zZEOwFmxGN/bCKuCOUZibIFlRD8bmJOb2gbMz1Xb1uL2Ishq4k4BeOY=
X-Received: by 2002:ac2:4ac8:0:b0:513:55ed:918a with SMTP id
 m8-20020ac24ac8000000b0051355ed918amr1550158lfp.50.1709668822293; Tue, 05 Mar
 2024 12:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com> <20240304104409.2326422-8-ardb+git@google.com>
 <CAC_iWjKeKBd3O-i8Lodv4m5e8n=0Bss0N_mjc+jCj2QNgmaQzA@mail.gmail.com> <1425355b-d3b8-4066-acd9-aba5067d4afa@linux.intel.com>
In-Reply-To: <1425355b-d3b8-4066-acd9-aba5067d4afa@linux.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Mar 2024 21:59:45 +0200
Message-ID: <CAC_iWjK=VSw+-cZy5GPDt38GEaVwwWdD5C-wTuzLG4wJPRBwdg@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: Add Confidential Computing (CC)
 measurement typedefs
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 21:27, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 3/5/24 10:00 AM, Ilias Apalodimas wrote:
> > Hi Ard,
> >
> > On Mon, 4 Mar 2024 at 12:44, Ard Biesheuvel <ardb+git@google.com> wrote:
> >> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>
> >> If the virtual firmware implements TPM support, TCG2 protocol will be
> >> used for kernel measurements and event logging support. But in CC
> >> environment, not all platforms support or enable the TPM feature. UEFI
> >> specification [1] exposes protocol and interfaces used for kernel
> >> measurements in CC platforms without TPM support.
> >>
> >> More details about the EFI CC measurements and logging can be found
> >> in [1].
> >>
> >> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> [ardb: Drop code changes, keep typedefs and #define's only]
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> ---
> >>  drivers/firmware/efi/libstub/efistub.h | 79 ++++++++++++++++++++
> >>  include/linux/efi.h                    |  1 +
> >>  2 files changed, 80 insertions(+)
> >>
> > [...]
> >
> >> +
> >> +struct efi_cc_event {
> >> +       u32 event_size;
> >> +       struct {
> >> +               u32 header_size;
> >> +               u16 header_version;
> >> +               u32 mr_index;
> >> +               u32 event_type;
> >> +       } __packed event_header;
> >> +       u8 event_data[0];
> > We should define this as a flexible array member instead of a zero-length array?
> > The spec is funny and defines this as event_data[1]. I think we aren't
> > using the sizeof(struct efi_cc_event) anywhere, so if this struct is
> > not used as a member of another struct or an array we can omit it
> > entirely.
>
> Flexible array is also fine or we can just add a comment like "u8[] event follows here"
> like in struct efi_tcg2_event .

Yes. I just noticed I had a typo above. I meant to write "if this
struct *is* used as a member of another struct or an array we can omit
it entirely."

>
> >
> > [...]
> >
> > Cheers
> > /Ilias
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

