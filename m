Return-Path: <linux-efi+bounces-1930-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F19C996D35
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB26F1F24228
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC0199EAD;
	Wed,  9 Oct 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="FkSzYKLd"
X-Original-To: linux-efi@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E661FEB;
	Wed,  9 Oct 2024 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482750; cv=none; b=KTeSxxRTeN1O2YXfezZeF0nXv9sNd5UDcKcVf8gRSumnEWqcjvILYlliN3HdRhQshVZ85m4NBCCyeudYGt14G8P9vzOw+sJEjf5JDpMZk+48cJsxpxI4zIwW5tr5GkivfVqIbyS5T/qhtEY1GcFH6fd0RsPi4Roy9YNgU0wh7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482750; c=relaxed/simple;
	bh=cgGY/g9Do3DxKpevKWY1WFv03l4BieX+1o+4n9S8MXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctCDdTFIOQU6+NtsZ0+zZh4u5ZctyddJnYq4j0dvMldXlpLkxQmqJ4wcTx+rV+uLYB6kFOUowWZXy2oby6akeFWlrBmNhiUgn1/r0rRaWdNIWIK9ANNdbePkU+1tYjmcgj61gO7JexLtmH6G2AYkF4FyziFI4iHAUy5F8s2jTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=FkSzYKLd; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=i1QThVF8dGkG2MCAzs0bja3ZVNDTNwm3Axl492fNNQY=; b=FkSzYKLdsa0heLdvcU+riirsHk
	5ldUDp/FP484xNSeeztScBp45hUlq+ZRp+wFFrY3fB9dYaTM5pKpFhP6/ewD76V3QCwv8/JvJhEcV
	om5c+iz9GUHRUQ6ay9DhFugwZqTha4QeyBYGvqhXtxqQ43eA8REg+8FQxcl6iCLgZG6DTbw2pbPpn
	SFH1YTPoJgRJqhFEa/6r4L0RTtxQQ5kDFJqWu4UxdQBeiVutp3cGLMmTuQ917o4vJKXyQVU8sPFgz
	5ls/1NhgvclwdaR8wH0J0ZoZI7bvsFNbvFe5rwZ3l6XpnzVaEomulvUec2qCSZkmJC/3xpxeRPtNh
	ThsOA9oA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1syXJa-003F6L-2V;
	Wed, 09 Oct 2024 15:05:22 +0100
Date: Wed, 9 Oct 2024 15:05:22 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net,
	linux-integrity@vger.kernel.org
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <ZwaNorA0hUhdQ8ji@earth.li>
References: <20240913-careful-maroon-crab-8a0541@leitao>
 <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
 <87o74n5p05.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
 <874j6e482p.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
 <87setx3b8l.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>
 <ZwZIoQobJrltBpTX@earth.li>
 <20241009-feathered-polar-manul-ea6e33@leitao>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-feathered-polar-manul-ea6e33@leitao>

On Wed, Oct 09, 2024 at 03:46:32AM -0700, Breno Leitao wrote:
> On Wed, Oct 09, 2024 at 10:10:57AM +0100, Jonathan McDowell wrote:
> > On Wed, Sep 18, 2024 at 09:36:06AM +0200, Ard Biesheuvel wrote:
> > > On Wed, 18 Sept 2024 at 05:14, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > > Ard Biesheuvel <ardb@kernel.org> writes:
> > > > > On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > > >> Ard Biesheuvel <ardb@kernel.org> writes:
> > 
> > > > >> This should not be the kexec-on-panic kernel as that runs in memory
> > > > >> that is reserved solely for it's own use.  So we are talking something
> > > > >> like using kexec as a bootloader.
> > > > >
> > > > > kexec as a bootloader under TPM based measured boot will need to do a
> > > > > lot more than pass the firmware's event log to the next kernel. I'd
> > > > > expect a properly engineered kexec to replace this table entirely, and
> > > > > include the hashes of the assets it has loaded and measured into the
> > > > > respective PCRs.
> > > > >
> > > > > But let's stick to solving the actual issue here, rather than
> > > > > philosophize on how kexec might work in this context.
> > > >
> > > > I am fine with that.  The complaint I had seen was that the table was
> > > > being corrupted and asking how to solve that.  It seems I haven't read
> > > > the part of the conversation where it was made clear that no one wants
> > > > the tpm_log after kexec.
> > > >
> > > It was not made clear, that is why I raised the question. I argued
> > > that the TPM log has limited utility after a kexec, given that we will
> > > be in one of two situations:
> > > - the kexec boot chain cares about the TPM and measured boot, and will
> > > therefore have extended the TPM's PCRs and the TPM log will be out of
> > > sync;
> > > - the kexec boot chain does not care, and so there is no point in
> > > forwarding the TPM log.
> > > 
> > > Perhaps there is a third case where kdump wants to inspect the TPM log
> > > that the crashed kernel accessed? But this is rather speculative.
> > 
> > Generally the kernel/host OS and the firmware are touching different
> > PCRs in the TPM.
> > 
> > The firmware eventlog covers what the firmware/bootloader measured;
> > itself, option ROMs, secure boot details, bootloader, initial
> > kernel/initrd (if we're talking grub as the initial bootloader). These
> > details are not changed by a kexec, and provide the anchor of the
> > software trust chain.
> > 
> > A kexec'd kernel will generally not touch the same PCRs. The primary way
> > I know to carry kexec measurements / logs over to new kernels is using
> > IMA, which will be configured to use one of the later PCRs (default of
> > 10).
> 
> What about in the case where you don't have Grub, but, use the kernel as
> the bootloader, kexecing into the desired kernel?
> 
> Will the bootloader-kernel touch the same PCRs as GRUB, or it will only
> touch PCRs above 10?

A kernel kexecing into another will generally use IMA if it wants to
measure into the TPM, which will use PCR 10 by default and not conflict
with the firmware PCRs (and you then use the IMA integrity log, which is
passed over a kexec, to work out the kexec side of things).

You still need the firmware event log in that case because the
"bootloader" kernel combo you load is measured into the TPM by the
firmware.

You _could_ technically configure things up to re-use some of the
firmware PCRs, but it generally wouldn't make a lot of sense to do so
and I've not seen any examples of that sort of configuration.

J.

-- 
101 things you can't have too much of : 41 - Tea.

