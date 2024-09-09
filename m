Return-Path: <linux-efi+bounces-1687-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4EB971CBC
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6431C28372A
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C41BAEC1;
	Mon,  9 Sep 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="T9Hx3nvM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RW8vWb3Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B701B3B11;
	Mon,  9 Sep 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892627; cv=none; b=ZOuFAYF6/Vv7iqmIegsrBS5EvzuISZmrqc7FBZ1D5zEKfyusCQwnr4pYMkCB16apdO8m4m8wUqL/c/IWqg/t6p9nrJIiih78FJq9T/37X0lDTXGc9i4uqM+macBKDYPcgmHgd9iW7qdD3vskc79eeF7drK0Gc9Cw5nzxGQOmmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892627; c=relaxed/simple;
	bh=uoZbSiJC/ovGQAf7d5Or1dxDgfxNN20clmzgxCmsYY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVGzBYnRRnj6ICbxa2xEnalddB9AtJmqbItXBOO70hz1cweSbl9xOa4vWWBBruNUH4a9v3ZnAicGjLmDGfehP6Mqo21CCjNVeFJm4CyI/fIK9N5jvS+uVPyi/2diOS0a3uhnIJcLsWzcmyM9629vHU98mX9kHIJiwbUcsim/fcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=T9Hx3nvM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RW8vWb3Z; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E7B021380225;
	Mon,  9 Sep 2024 10:37:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Sep 2024 10:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1725892624; x=1725979024; bh=PGrDzIuNXk
	woLQBLlTew5GzRcdRT4GoGBHO02S2JrMQ=; b=T9Hx3nvMWNPCQfObLPaWaI38HZ
	+aP3Q4zf4fbDUxTz6uTG6Qe/57tEB2PTVRDdG1nKgmpCsEqqZwHOBNifN4t77ILU
	Q2ILBmbeQC3NFF/SzHj9ysDFoHvAGfJP6haI4tYfdGE2M9rf9k+7oUJpywgbXZ6c
	QxA8qZ3RuMMGtpasZtsrQn87Wrfhb67CvDPfy0VTel1/7SbHa16byIxcDz89M5nV
	ElayrfOXBupJdqPumfmk1BjOunJAKLgouNTzCwY0bNuhO/kw3Ew7QQB+jH0G1oo9
	GRzx1dVl/oI4lPar5TMsWoH1Sbjqnqah4Ppl864J6VdZF5ETa9hYlPmYUTYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725892624; x=1725979024; bh=PGrDzIuNXkwoLQBLlTew5GzRcdRT
	4GoGBHO02S2JrMQ=; b=RW8vWb3ZaHIA3fiGtT7ZQlN9G7OiV088/vl2GUrX6iQ/
	+Yt9FrgjqxVnzpL1Bqjq1MpLl6PoZVkggAVeSGEH+ls8WEo9xqEUE7C97KH51cpm
	txsiD1OZWq9mgo8SN40QDeTgJyweJTlIVr4G89GzUGxaRfGjoSYhDNhDv7NKx63/
	fDI/++cD1vVPL2a+WbEYL97lMTSRtOFBn7KkgvMCvYBuWOVofd5SgSV+zqtiLWc/
	bb8jXgxiSTLg4b7UKnYSsMRXvO8pKLn89dbIztyVfSTtRzxEznXcN7cKEzbfg+Mx
	6y63U9QZUj4t/xn+8FCuUjyVkv4l2ATo8rURgio++w==
X-ME-Sender: <xms:EAjfZrCCl4_WhXRdrgldCI1wLMnSX4tjrhdmuNJG8q0YpYwopK2rBw>
    <xme:EAjfZhjhIqX3l7xY4XXMlnUYO2CdKLlYEnJfKtXdhOvjIXzona-LMGzpBnOBvdzut
    v-gydIuOuZXuZapZVU>
X-ME-Received: <xmr:EAjfZmm_le99CTZgubDZnLb78-aocXsV8Y1hzMtGOqo37RVjGA-AEnhBjvtUpnmdxn6077V-2LK0RIyjd04520ynE0D3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrh
    cuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeehgeefffej
    veeuleekueeguefftdefhefgtedtieeghefhtefgiefhiefhtdetheenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrdgttgdpnhgspghrtghpthhtohepud
    egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhruhguohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmh
    iigihrvggrrhihsedtphhoihhnthgvrhdruggvpdhrtghpthhtohepphhilhhiuhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepjhgrrhhkkhhosehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohep
    sghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepugihohhunhhgsehrvgguhhgrth
    drtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomh
X-ME-Proxy: <xmx:EAjfZtxBalTnTYZ2K8z8QH2obb7nzUdaxyh7XrIFgFqL2Vxub8_NMg>
    <xmx:EAjfZgR3fSN9YiZSvXsdumgu2vrENc2sy48uBo7apyxAfkRalXUVVA>
    <xmx:EAjfZgbh74UmtvdNxqEpORIHgOBChrPowf3QAhWs0bwrkhIIdFFG_g>
    <xmx:EAjfZhTFc6PRJ2L_2MHK-7W5UK_lbS5MpwgjAop9CpHZUYXhCzvLQQ>
    <xmx:EAjfZsoIVMkwy5q97bklK5eN1eQMHyFpPLJmFhsLcVLGALNhex6XCndc>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 10:37:02 -0400 (EDT)
Date: Mon, 9 Sep 2024 16:37:01 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Pingfan Liu <piliu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt8IDVMhUw7aAejR@archlinux>
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <Zt7EbvWjF9WPCYfn@gardel-login>
 <Zt7RJepoCiCMRZSu@archlinux>
 <20240909154940.7ab93782@rotkaeppchen>
 <CAMj1kXHN5NgUJ+wwaZxsKeT4bDHqO6C2CHaALAi7JV5hWVmR2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHN5NgUJ+wwaZxsKeT4bDHqO6C2CHaALAi7JV5hWVmR2A@mail.gmail.com>

On 09 16:04:50, Ard Biesheuvel wrote:
> 
> [...]
>
> kdump has a kexec kernel 'standby' to launch when the kernel panics.
> So for the UKI/EFI payload case, this would imply that the load
> involves running the payload until EBS() and freezing the state.
> 
> Whether execution occurs in true user space or in a deprivileged
> kernel context is an implementation detail, imho. We don't want to run
> external code in privileged mode inside the kernel in any case, as
> this would violate lockdown already. But it should be feasible to have
> a EFI compatible layer in the kernel that invokes the EFI entrypoint
> of an image in a way that protects the host kernel. This could be user
> mode on the CPU or perhaps a minimal KVM virtual machine.

This solution is what I'm currently in favor of (besides my original
approach), see: https://lore.kernel.org/kexec/Zt7EbvWjF9WPCYfn@gardel-login/T/#md4f02b7cb6c694cb28aa8d36fe47a02bd4dc17a4

From the perspective of supporting UKIs the EFI compatibility layer
definetly has to be run in the kernel not in regular userspace so that
the chain of trust is maintained.

Why do you say that it would have to be a deprivileged kernel context
though? In lockdown mode we would enforce a signature check on the PE
file, so it shouldn't be any different from loading a signed kernel
module from a kernel lockdown perspective, right?

Using KVM is actually something I didn't consider yet, however it would
not work in VMs without nested virtualization.

> The advantage of this approach is that the whole concept of purgatory
> can be avoided - the EFI boot phase runs in parallel with the previous
> kernel, which has full control over authentication and [emulated] PCR
> externsion, and has ultimate control over whether the kexec reboot is
> permitted.

I'm under the impression that we still need some code to run between the
kernels to do two things:

1. Clean up the address space, so that it's what the EFI binary expects
2. Verify a checksum on the saved state in case a kernel panic is the
result of memory corruption

Sure, the majority of the work (running the EFI binary until EBS()) is
done while the old kernel is still running.

>
> [...]
> 
> I don't think intermediate kernels are the solution here. We need to
> run as much as possible under the control of the preceding kernel, and
> minimize the bare metal handover that occurs after EBS(). Adding more
> code to the purgatory (as this series does) is not acceptable to me,
> as it is extremely difficult to debug, and duplicates drivers and
> other logic (making it an 'intermediate kernel' of sorts already)

I agree

> 
> Today, UKI functionality is implemented in terms of EFI API calls. Any
> solution that needs either a parallel implementation (eBPF vs EFI) or
> needs to unpack the UKI in order to perform the steps that the UKI
> would perform itself if it were executed in an EFI environment is a
> no-go in my opinion.
> 
> So either we provide some EFI compatible runtime sufficient to run a
> UKI, or we re-engineer UKI to be built on top of an abstraction that
> can be implemented straight-forwardly both on system firmware and in
> the EFI context.

A solution that can boot UKIs as they exist today is definetly the right
choice. Rewriting them for eBPF and maintaining two implementations is
way less than ideal.


