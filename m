Return-Path: <linux-efi+bounces-1929-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51286996792
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 12:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF92286836
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B367518E354;
	Wed,  9 Oct 2024 10:46:40 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED645948;
	Wed,  9 Oct 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470800; cv=none; b=cW4TM7VoAJvjFC9sZHiuWu+HVYj4ZQcrr0Nh79Z66s7wQJzGtQ8L4abXIeQuBJECI3MZfn9R5oTV/+W2jIrNF3fRo/gTOZ7rI+mHKy902JQUA4LFmNK5QR+8fzhtp7/k6lycSl2V2ifKxceG/fszo2H6wv4sTO4dJNL2F7D65YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470800; c=relaxed/simple;
	bh=Sip27StrS6XnyQHm1+Ggdhro9W5ZjCFargKWeuvD/dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSgFfQvnrUfGoWcP2XW3K2+x3vQkJ70W08jAT0lbYQy9y1K4obBKKyczZta81qzg+EPaer84oWfnKV6YZHYc1xCYgYg/bi9QHe58hy0LV4xx5/vCUgm3Z5LKZ6/1MJ5jcqadF8aDG4X8WdYaaoHAQs/ixMs83VJHxVY3WJd5Diw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso93686381fa.1;
        Wed, 09 Oct 2024 03:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728470796; x=1729075596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNMFGv2yRXisTXc7gWT2h+fzh59yEWTgP+a8tlpKQSw=;
        b=PRWhVQXSHIpJM4VW4yx5X8txJTZh0mUnz33isp9pVJ9q0pk1p20iuWuWlfm2iW87Hg
         6Jx/lX5ijpmtdrh8GcZNUss95vjNITLRVvBTI2fFrr1tzKOH06P6Ywlk1mZrOg+I7sU+
         zQXh+TFhETl4/PSdDhI4nII6c7kIm/KRWsiNGww4ODcOZwZGvWB8KW5GRg+OKhQeOFKu
         qzDmSDTPFEM/L+n1xzgsk/OqRywehjvVOokuewcuAUXUwYt4+DCn+xQMpqgthvEWc6/D
         H6jtm8R8lkC5xPv85T4Lhja5u443HSfgn1GWifbLstQlyI8s2HB4hrksolZNM2uj9r3z
         wJWw==
X-Forwarded-Encrypted: i=1; AJvYcCUlpYCF8X6sNA5z4cJDt9tlCZ7pHHoB+YMU4ITbu5xoNl4okog37wOyouIZ6CAvuZ9F8mFVEOZ+D1ZHhGYw@vger.kernel.org, AJvYcCVmzmSiYNApxRHIIYN4sgpYI6jMOqy7Z5Bd2Zpu4F70hJrnYewZp8rsjw9pBB4FNKwLFPeDFe+r69o4YDZYM9Gn@vger.kernel.org, AJvYcCVoC8WpASFIFNw6UHgCgEA3oMRuDzKgd0tMYrMlWkdCJzjd2w1yMdJewn7eoMM13SWgdnFgtgAXllM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTttuYyYp3wkemM1GzLUgUJXwTTy+4pMVupwF5HLASSWrbDwq
	wzX9QlphkDN6sdbqXtIy5kmH6O0+v088Zb6wEo7NCmDJui1iDu/d/jIdO7Cd
X-Google-Smtp-Source: AGHT+IGBgPyvl5kI21wnDB/KVv5sxzPHbM6/6Kuir7Lxse6lIyMw/Z/TaRG/9tgMZmWq+QJVbcztyQ==
X-Received: by 2002:a05:651c:2126:b0:2fa:d49d:45ae with SMTP id 38308e7fff4ca-2fb1871e4f5mr19755081fa.8.1728470795507;
        Wed, 09 Oct 2024 03:46:35 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99446bd93asm522407566b.82.2024.10.09.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 03:46:35 -0700 (PDT)
Date: Wed, 9 Oct 2024 03:46:32 -0700
From: Breno Leitao <leitao@debian.org>
To: Jonathan McDowell <noodles@earth.li>
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
Message-ID: <20241009-feathered-polar-manul-ea6e33@leitao>
References: <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
 <20240913-careful-maroon-crab-8a0541@leitao>
 <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
 <87o74n5p05.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
 <874j6e482p.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
 <87setx3b8l.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>
 <ZwZIoQobJrltBpTX@earth.li>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwZIoQobJrltBpTX@earth.li>

On Wed, Oct 09, 2024 at 10:10:57AM +0100, Jonathan McDowell wrote:
> On Wed, Sep 18, 2024 at 09:36:06AM +0200, Ard Biesheuvel wrote:
> > On Wed, 18 Sept 2024 at 05:14, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > Ard Biesheuvel <ardb@kernel.org> writes:
> > > > On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > >> Ard Biesheuvel <ardb@kernel.org> writes:
> 
> > > >> This should not be the kexec-on-panic kernel as that runs in memory
> > > >> that is reserved solely for it's own use.  So we are talking something
> > > >> like using kexec as a bootloader.
> > > >
> > > > kexec as a bootloader under TPM based measured boot will need to do a
> > > > lot more than pass the firmware's event log to the next kernel. I'd
> > > > expect a properly engineered kexec to replace this table entirely, and
> > > > include the hashes of the assets it has loaded and measured into the
> > > > respective PCRs.
> > > >
> > > > But let's stick to solving the actual issue here, rather than
> > > > philosophize on how kexec might work in this context.
> > >
> > > I am fine with that.  The complaint I had seen was that the table was
> > > being corrupted and asking how to solve that.  It seems I haven't read
> > > the part of the conversation where it was made clear that no one wants
> > > the tpm_log after kexec.
> > >
> > It was not made clear, that is why I raised the question. I argued
> > that the TPM log has limited utility after a kexec, given that we will
> > be in one of two situations:
> > - the kexec boot chain cares about the TPM and measured boot, and will
> > therefore have extended the TPM's PCRs and the TPM log will be out of
> > sync;
> > - the kexec boot chain does not care, and so there is no point in
> > forwarding the TPM log.
> > 
> > Perhaps there is a third case where kdump wants to inspect the TPM log
> > that the crashed kernel accessed? But this is rather speculative.
> 
> Generally the kernel/host OS and the firmware are touching different
> PCRs in the TPM.
> 
> The firmware eventlog covers what the firmware/bootloader measured;
> itself, option ROMs, secure boot details, bootloader, initial
> kernel/initrd (if we're talking grub as the initial bootloader). These
> details are not changed by a kexec, and provide the anchor of the
> software trust chain.
> 
> A kexec'd kernel will generally not touch the same PCRs. The primary way
> I know to carry kexec measurements / logs over to new kernels is using
> IMA, which will be configured to use one of the later PCRs (default of
> 10).

What about in the case where you don't have Grub, but, use the kernel as
the bootloader, kexecing into the desired kernel?

Will the bootloader-kernel touch the same PCRs as GRUB, or it will only
touch PCRs above 10?

Thanks
--breno

