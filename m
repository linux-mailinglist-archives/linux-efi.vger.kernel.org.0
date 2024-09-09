Return-Path: <linux-efi+bounces-1684-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A62971B90
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 15:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48164B2297E
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E851B3F23;
	Mon,  9 Sep 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxyFy45x"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91D1EEFC
	for <linux-efi@vger.kernel.org>; Mon,  9 Sep 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889798; cv=none; b=XlLcIQ/Yutb6vSt8OZzdrMbaJ26uM/Je3yza1WFl+K/xCBXJF51UQiBr1CTNyR3hKqC9cNw3ulWbrLh1X8RgWrP1oJiujs1VaxbpQe2UwGJJ3+LdkRF3X0LAOHwo5LsPFK+qQDltXXl8wsNPl9ZwqPLZLlbSwJrTCeyB6Z1b3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889798; c=relaxed/simple;
	bh=wh5yd184Gp377R7e8Qqjl2Jb+VgwG6GPDebtOhfpZAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ap72oU1CUa16kvihoDYNhVjdck4D+pyumpEIB16oa/vlRtoERgjhXsERIHn6pMaEV57MQ5kia9Zpd8vUViut9QM8jSDPGNM3rr0X8EwmoPbqTXSA5AjKjZCg3UfeNFKnWvFmlTZcr47egf6/MTMuTigJgEdHFMvvCa0zzpyxDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxyFy45x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725889796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TpJPlDmtPMRkb1dmpqSkOrnyBEBZ+RvdmDZohxd9xQ=;
	b=UxyFy45xd0zYov+SGZxrQPf1ZovMpaTYGgpDDWF7YWTTj22uIjvXuTSIMg6eyic1VNBXMr
	Wqhb0cudA8PBZCmQTH1ELj4p7DB5RXaz8MIQYymSbAT1bGneAjWV+AFAMe68+Ma29EmXBR
	/e4MjpIZOU5+C6mShly5td/3SD6i1tI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-EFYW_jHpPhyBaRlluMebtg-1; Mon,
 09 Sep 2024 09:49:51 -0400
X-MC-Unique: EFYW_jHpPhyBaRlluMebtg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24D97195394A;
	Mon,  9 Sep 2024 13:49:49 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2ABF01956048;
	Mon,  9 Sep 2024 13:49:42 +0000 (UTC)
Date: Mon, 9 Sep 2024 15:49:40 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Lennart Poettering <mzxreary@0pointer.de>, Ard Biesheuvel
 <ardb@kernel.org>, Pingfan Liu <piliu@redhat.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He
 <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <20240909154940.7ab93782@rotkaeppchen>
In-Reply-To: <Zt7RJepoCiCMRZSu@archlinux>
References: <20240819145417.23367-1-piliu@redhat.com>
	<CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
	<20240906125438.1e54c5f6@rotkaeppchen>
	<Zt7EbvWjF9WPCYfn@gardel-login>
	<Zt7RJepoCiCMRZSu@archlinux>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Lennart,
Hi Jan,

On Mon, 9 Sep 2024 12:42:45 +0200
Jan Hendrik Farr <kernel@jfarr.cc> wrote:

> On 09 11:48:30, Lennart Poettering wrote:
> > On Fr, 06.09.24 12:54, Philipp Rudo (prudo@redhat.com) wrote:
> >   
> > > I mostly agree on what you have wrote. But I see a big problem in
> > > running the EFI emulator in user space when it comes to secure boot.
> > > The chain of trust ends in the kernel. So it's the kernel that needs to
> > > verify that the image to be loaded can be trusted. But when the EFI
> > > runtime is in user space the kernel simply cannot do that. Which means,
> > > if we want to go this way, we would need to extend the chain of trust
> > > to user space. Which will be a whole bucket of worms, not just a
> > > can.  
> > 
> > May it would be nice to have a way to "zap" userspace away, i.e. allow
> > the kernel to get rid of all processes in some way, reliable. And then
> > simply start a new userspace, from a trusted definition. Or in other
> > words: if you don't want to trust the usual userspace, then let's
> > maybe just terminate it, and create it anew, with a clean, pristine
> > definition the old userspace cannot get access to.  
> 
> Well, this is an interesting idea!
> 
> However, I'm sceptical if this could be done in a secure way. How do we
> ensure that nothing the old userspace did with the various interfaces to
> the kernel has no impact on the new userspace? Maybe others can chime in
> on this? Does kernel_lockdown give more guarantees related to this?
> 
> Even if this is possible in a secure way, there is a problem with doing
> this for kernels that are to be kexec'd on kernel panic. In this
> approach we can't pre-run them until EBS(), so we would rely on the old
> kernel to still be intact when we want to kexec reboot.

I don't believe there's a way to do that on running kernels. As Jan
pointed out, this cannot be done during reboot, as for kdump that would
mean to run after a panic. So it would need to run when the new image
is loaded. But at that time your user space is running. Plus you also
always have a user space component that triggers kexec. So you cannot
simply "zap" user space but have to somehow stash it away, run your
trusted user space and, then restore the old user space again. That
sounds pretty error prone to me. Plus it will tank your performance
every time you do a kexec, which for kdump is every boot...

> You could do a system where you kexec into an intermediate kernel. That
> kernel get's kexec'd with a signed initrd that can use the normal
> kexec_load syscall to load do any kind of preparation in userspace.
> Problem: For that intermediate enviroment we already need a format
> that combines kernel image, initrd, cmdline all signed in one package
> aka UKI. Was it the chicken or the egg?
> 
> But this shows that if we implemented UKIs the easy way (kernel simply
> checks signature, extracts the pieces, and kexecs them like normal),
> this approach could always be used to support kexec for other future
> formats. They could use the kernels UKI support to boot into an
> intermediate kernel with UEFI implemented in userspace in the initrd.
> 
> So basically support UKIs the easy way and use them to be able to
> securely zap away userspace and start with a fresh kernel and signed
> userspace as a way to support other UEFI formats that are not UKI.

Well, in theory that should work. But I see several problems:

1) How does the first kernel tell the intermediate kernel which
file(s) with wich command line to load? In fact, how does the first
kernel get the information itself? You would need a new system call
that takes two kernel images, one for the intermediate and one for the
kernel to load,for that.

Of course you could also build the intermediate UKI during kernel build
and include it into the image. Similar to what is done with the
purgatory. But that would totally bloat the kernel image. 

2) I expect that to be extremely painful to debug, if the intermediate
kernel runs into a panic. For sure kdump won't work in that case...

3) Distros would need maintain and test the additional UKI.

4) This approach basically needs to boot twice. But there are people
out there who fight to reduce boot times extremely hard. For them every
millisecond counts. Telling them that they will need to wait twice as
long will be very hard to sell.

> >   
> > > Let me throw an other wild idea in the ring. Instead of implementing
> > > a EFI runtime we could also include a eBPF version of the stub into the
> > > images. kexec could then extract the eBPF program and let it run just
> > > like any other eBPF program with all the pros (and cons) that come with
> > > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > > simply kexec any OS installer. On the other hand it would make it
> > > easier to port UKIs et al. to non-EFI systems. What do you think?  
> > 
> > ebpf is not turing complete, I am not sure how far you will make it
> > with this, in the various implementations of EFI payloads there are
> > plenty of loops, sometimes IO loops, sometimes hash loops of huge data
> > (for measurements). As I understand ebpf is not really compatible such
> > code.

I don't believe we can simply take all those payloads and recompile
them to eBPF. There definitely needs to be some refactoring done first.
For example the IO loops you can drop for eBPF and simply map to the
corresponding kernel function, letting them do the full IO in one go.
There will be cases where that will be more difficult like for hash
loops when you have to have the same hash at the end. But I believe
even for that ways could be found to get it to work.

Anyway, I'm sure that the picture I have in my head is way
oversimplified. There will be many pitfalls to handle for sure. Still I
believe it would be a nice experiment.

Thanks
Philipp


