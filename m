Return-Path: <linux-efi+bounces-1272-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29166912996
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 17:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C72281880
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8868B6E2BE;
	Fri, 21 Jun 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjgfR2pS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C92C859;
	Fri, 21 Jun 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983611; cv=none; b=iIFYURNzEKe1hvd0nklpZVEo3PQS/x1lSX1orU+7XP3aieceu8xRreYq0lKTyh5iXSJ5KnyahLxqYW4TJ/R+6GAPDegq+6QVI/CTCeY0059wgW+UVSkpaqD5QAmC/AA1io9JeuznP09sptpXwPLTEK58Db+ivPsC4AT2hZJn1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983611; c=relaxed/simple;
	bh=VZvSfmYm+YYVRqepGXv0DdjyARWDuL62j88rb4mTLp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcbMj0QPi4mdUpEbLW9LNNRl6LXavnVzV1zlkRBSyRsGyetM2JglMCIgbgVuUXgZPAfRvrhIlHce6WSr8Yjrzw3R3RhkwdIZt7Qg26yf47jMiqcMPWxSsBn1LLyIcRjWIWgFkLpZTzKhqOAUk1wMBEkwIlFFpjVsSB6DHdiWKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjgfR2pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800DBC2BBFC;
	Fri, 21 Jun 2024 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718983610;
	bh=VZvSfmYm+YYVRqepGXv0DdjyARWDuL62j88rb4mTLp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jjgfR2pS0CHoifVSOF1onh/LnD0rkt0ywgTtfPTp8Z/ExNi3fEMRKXheQljQ5MD+0
	 0SxeOr7K2dbNDaIl7JA2t4EpQq38fKOCioK9Wv/ldlMFLtrgnVWk7hsfJfRYwJmDpN
	 U0An75uWq4M4cOkVAWKwfBYJQCqFzGHmbKzcuY0/q85PPfraFxrJLorSjN8DlKAQFi
	 sQA0movE0zwX+WiW7wsKA4EmWQRdAqobO+Lwggjw9Ik97hTdnHqubZ4WyRaG0x9Sa1
	 j+z5y+EEJsP88ECJj0iUm5/rlNISaqWL7g4vHkvPGu5hNYit8dKI4Fb8cZ1MlqPlpt
	 M2sONNaQa/3NA==
Date: Fri, 21 Jun 2024 17:26:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James
 Morse <james.morse@arm.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Fix CPER issues related to UEFI 2.9A Errata
Message-ID: <20240621172645.21082af3@coco.lan>
In-Reply-To: <CAMj1kXHsyAhmV9K__pRh8cYJy-ed2-s5VLDE4GwMqNajvJE46w@mail.gmail.com>
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
	<CAMj1kXHsyAhmV9K__pRh8cYJy-ed2-s5VLDE4GwMqNajvJE46w@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ard,

Em Fri, 21 Jun 2024 09:45:16 +0200
Ard Biesheuvel <ardb@kernel.org> escreveu:

> On Thu, 20 Jun 2024 at 20:01, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > The UEFI 2.9A errata makes clear how ARM processor type encoding should
> > be done: it is meant to be equal to Generic processor, using a bitmask.
> >
> > The current code assumes, for both generic and ARM processor types
> > that this is an integer, which is an incorrect assumption.
> >
> > Fix it. While here, also fix a compilation issue when using W=1.
> >
> > After the change, Kernel will properly decode receiving two errors at the same
> > message, as defined at UEFI spec:
> >
> > [   75.282430] Memory failure: 0x5cdfd: recovery action for free buddy page: Recovered
> > [   94.973081] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > [   94.973770] {2}[Hardware Error]: event severity: recoverable
> > [   94.974334] {2}[Hardware Error]:  Error 0, type: recoverable
> > [   94.974962] {2}[Hardware Error]:   section_type: ARM processor error
> > [   94.975586] {2}[Hardware Error]:   MIDR: 0x000000000000cd24
> > [   94.976202] {2}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x000000000000ab12
> > [   94.977011] {2}[Hardware Error]:   error affinity level: 2
> > [   94.977593] {2}[Hardware Error]:   running state: 0x1
> > [   94.978135] {2}[Hardware Error]:   Power State Coordination Interface state: 4660
> > [   94.978884] {2}[Hardware Error]:   Error info structure 0:
> > [   94.979463] {2}[Hardware Error]:   num errors: 3
> > [   94.979971] {2}[Hardware Error]:    first error captured
> > [   94.980523] {2}[Hardware Error]:    propagated error captured
> > [   94.981110] {2}[Hardware Error]:    overflow occurred, error info is incomplete
> > [   94.981893] {2}[Hardware Error]:    error_type: 0x0006: cache error|TLB error
> > [   94.982606] {2}[Hardware Error]:    error_info: 0x000000000091000f
> > [   94.983249] {2}[Hardware Error]:     transaction type: Data Access
> > [   94.983891] {2}[Hardware Error]:     cache error, operation type: Data write
> > [   94.984559] {2}[Hardware Error]:     TLB error, operation type: Data write
> > [   94.985215] {2}[Hardware Error]:     cache level: 2
> > [   94.985749] {2}[Hardware Error]:     TLB level: 2
> > [   94.986277] {2}[Hardware Error]:     processor context not corrupted
> >
> > And the error code is properly decoded according with table N.17 from UEFI 2.10
> > spec:
> >
> >         [   94.981893] {2}[Hardware Error]:    error_type: 0x0006: cache error|TLB error
> >
> > Mauro Carvalho Chehab (3):
> >   efi/cper: Adjust infopfx size to accept an extra space
> >   efi/cper: Add a new helper function to print bitmasks
> >   efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
> >  
> 
> Hello Mauro,
> 
> How this is v4 different from the preceding 3 revisions that you sent
> over the past 2 days?
> 
> I would expect an experienced maintainer like yourself to be familiar
> with the common practice here: please leave some time between sending
> revisions so people can take a look. And if there is a pressing need
> to deviate from this rule, at least put an explanation in the commit
> log of how the series differs from the preceding one.

Sorry, I'll add a version review on that. Basically I was missing a
test environment to do error injection. When I got it enabled, and fixed
to cope with UEFI 2.9A/2.10 expected behavior, I was able to discover 
some issues and to do some code improvements.

v1: 
- (tagged as RFC) was mostly to give a heads up that the current 
  implementation is not following the spec. It also touches
  only cper code.

v2:
- It fixes the way printks are handled on both cper_arm and ghes
  drivers;

v3:
- It adds a helper function to produce a buffer describing the
  error bits at cper's printk and ghes pr_warn_bitrated. It also
  fixes a W=1 error while building cper;

v4:
- The print function had some bugs on it, which was discovered with
  the help of an error injection tool I'm now using.

I have already another version ready to send. It does some code
cleanup and address the issues pointed by Tony and Jonathan. If you
prefer, I can hold it until Monday to give you some time to look
at it.

Thanks,
Mauro

