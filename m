Return-Path: <linux-efi+bounces-2156-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED99CDC6D
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 11:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5111B2789F
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DD13D51E;
	Fri, 15 Nov 2024 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly8k4TFR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15D192D61
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666106; cv=none; b=Wf4cj8E+qvpLty/zQcMpnrGGZHAIavPIULJ2nUE6rturTCKS7wv1Wf1HFt3FMCi3BThpB+c7Of4+90VyaP8E7r6An5V/5c0dMutJ7qfLdAYXDlPTBF6iGpgv2uWthLY4nK3QAAx7uyYBQGnuOtItOtxnTL/tnHN9TIyzvGIq2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666106; c=relaxed/simple;
	bh=rEC1X5rB3wRkIKMnxM1u0fzh6Heu5haSny6x0Ss2EaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL0Fh2yMVSkEJtYblhILGKgkEVCorC/riIl2SthqgsuaIXYLIK4qphvS3ddoNh5G0uGfA8HDsn1UHgyBUnYYK3WavBSpx9duABoWsQI59mWO2SECffB0k9MRjdWG+AjO1aVmv5oetQa5RzSGXcv3SjR5vDRrxRjn0C/eydpsU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly8k4TFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB68C4AF09
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731666106;
	bh=rEC1X5rB3wRkIKMnxM1u0fzh6Heu5haSny6x0Ss2EaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ly8k4TFRugEMJG8Xn5tgMML0rdp220/sxu1Nh60hwjZeprmP42Tjp0w6ARc2WMxi4
	 gMoAtXce31XWmLMcVW+JovI/rKahE6pgrheMFrs8RKQxatfhSf0ErgYda0ocJOsGbi
	 /TGsv7bB5J8+oQP+80sRf7Rq/H5TEfVmi95gzerNBEewQ2SJiB3q7kYt0KVYDvbL5w
	 mjRES/xBnMAKzUoVdZopBzC2SAEgFsmTAhC2qQHpWINDNwa5oXXTuJwoHKRMBum+RK
	 SySz6EC58Cmt0npu/WofptFwShRjwg/upSnPyPw7x8LfiH844h1E818pfv0t/EPHRN
	 3tDP2uEidZA6A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f84907caso1718183e87.3
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 02:21:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtEvl1wmGLfAu9adnNP+c77fSR5DRPsPtAqo1cOOSvo/D1gWu2VZrB0Ovbc/Jge/4Q82G3mCDbJa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRT1wrN/9HPF9w9k/dm1SqxHe5q3c5gcG5HYImKrknS9WurGN
	rsJDWe4reTrBfTVzeP01InIAmD3TLnKn3WsMOxmEBXFniflhS8TayM/Km/ZfFzHKtnp5VFkBNr3
	FyB6S7g3+nj4n4pPabvNC6juvSbM=
X-Google-Smtp-Source: AGHT+IHECuDtUVKQEdfEhzpzIWYrEjG5WZ1BU0HLv2/smv0NiKrwttYoM9cWe5h54QkUkTGH/YvX3G9Su08zvBvK58E=
X-Received: by 2002:ac2:568d:0:b0:53d:a68f:d901 with SMTP id
 2adb3069b0e04-53dab29cb57mr1078645e87.15.1731666104700; Fri, 15 Nov 2024
 02:21:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031175822.2952471-2-ardb+git@google.com> <20241115-honored-macho-deer-dc6def@leitao>
In-Reply-To: <20241115-honored-macho-deer-dc6def@leitao>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Nov 2024 11:21:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFjjMcHkbFAsSWJuqtzi2raJgLikx37ipxAB9f0ymXNQA@mail.gmail.com>
Message-ID: <CAMj1kXFjjMcHkbFAsSWJuqtzi2raJgLikx37ipxAB9f0ymXNQA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/memattr: Ignore table if the size is clearly bogus
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 11:10, Breno Leitao <leitao@debian.org> wrote:
>
> Hello Ard,
>
> On Thu, Oct 31, 2024 at 06:58:23PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > There are reports [0] of cases where a corrupt EFI Memory Attributes
> > Table leads to out of memory issues at boot because the descriptor size
> > and entry count in the table header are still used to reserve the entire
> > table in memory, even though the resulting region is gigabytes in size.
> >
> > Given that the EFI Memory Attributes Table is supposed to carry up to 3
> > entries for each EfiRuntimeServicesCode region in the EFI memory map,
> > and given that there is no reason for the descriptor size used in the
> > table to exceed the one used in the EFI memory map, 3x the size of the
> > entire EFI memory map is a reasonable upper bound for the size of this
> > table. This means that sizes exceeding that are highly likely to be
> > based on corrupted data, and the table should just be ignored instead.
>
> I haven't seen this patch landing in net-next tree yet.
> Do you have plan to have this merged into 6.13?
>

Nobody replied to it, so I wasn't going to.

Would you like this patch to be taken for v6.13? Does it fix the
issues you have been observing?

