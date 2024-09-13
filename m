Return-Path: <linux-efi+bounces-1729-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EAA977F0F
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B8E1C21B94
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30FA1D88A0;
	Fri, 13 Sep 2024 11:57:57 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69292762D7;
	Fri, 13 Sep 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228677; cv=none; b=ehCL7sLo02FuPxhhrRfVqYDolO9fD6quBOmolL+mtAsq5Qhlpk1CRd/uFO1iIed3MJGAkesI4SNfPhPut6qXnocOtTqGrDg5Z0ChkntpTR/NEPlkmmEHj1jOIjTVkbM62ReItpD4z0EL2fmpOonb4dSXPNBkJ21LCCpmO5iiCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228677; c=relaxed/simple;
	bh=ATeSZViA4hCQ8XnTQ0/d5V84KzTJBWaovYskqkYRslQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqNJqOc79aohFf5TkWlUMr5R5Yv9M1nIccAiSBppvQ7n/fgozRwGcq+aH8eOSu4oePgsjKEZ6v9dFYNJGl6FedsvcQ08nEAXGYCyxZceq92JPQ2fVt7OkFx4c8C+YvRXkLBMj9BxLbgEe/ykT8fRviqMPy99O9ROm0hQfQalAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8ce5db8668so322775766b.1;
        Fri, 13 Sep 2024 04:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228675; x=1726833475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI+zHtk2NVADatDuI+y5aY9OMDmt/UoADnsxa7QwLCs=;
        b=c+0r2Cw6VXU7o4Qsy/5+xm15uhJjMFSIG2CKRGl7aibEbE0isJaCIt5Q7yOckFEsyp
         POS1yp/zQgiuYP7xJUKGUx1zxb+hkg6jlYe5ZNgaTfykSrz3QPIWgrFjnXFyqaUuEDUr
         IZsvMTmtBYylRzSaJfsvBg7ImpH3HI8AfVWruGNEY4cvarKJ8vMqFNBDrVSBtubro2L+
         kC/2F1nRz7Qhz6wJd2CUwHqJCgkztWgQ7fMolzkAjjPHCIWudf8cFD2DTWsv4XikaJGo
         bScJdDbVNuX26n0gDAyrpqr9DLrdmIASNwNCLXkdNuUngtcli93lu1esU6KPxJxDsWL8
         kZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp1zEgNEHj7nuBQlXGg3tTdIw3ELQe+EuUW4mkGawllfncwdC96ep3+VKFGmLyCZxcRgq7Sxfd1/fVZx/G@vger.kernel.org, AJvYcCXJw5L9GaHjoGlTSYnrlr/7TO/qpD4edXNMFP2uEMLbCmVqAr04OG/7IbuRTxkw4zh/RJNvDfxZ/2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvTBpHLW1/dEiRzJ4St1z6OsUdnIfTs0ryuNjyaJMDQtNDEcy
	ql6DkVizP4vrOi5GAjLlVVP4onSkROCUsN2gQFjQlsQZwBQRFJ2Kxv23CA==
X-Google-Smtp-Source: AGHT+IFcfcf4C/OELpfH9TlUaARgUApLjqP4fVLpMOOD5SV7QEG5XU93VRdxoBgDgJgZt/M1wJCrxQ==
X-Received: by 2002:a17:906:730d:b0:a86:ab84:7fc1 with SMTP id a640c23a62f3a-a9029620359mr724581466b.50.1726228674122;
        Fri, 13 Sep 2024 04:57:54 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25831827sm857132766b.20.2024.09.13.04.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:57:53 -0700 (PDT)
Date: Fri, 13 Sep 2024 04:57:51 -0700
From: Breno Leitao <leitao@debian.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <20240913-careful-maroon-crab-8a0541@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>

Hello James,

On Thu, Sep 12, 2024 at 12:22:01PM -0400, James Bottomley wrote:
> On Thu, 2024-09-12 at 06:03 -0700, Breno Leitao wrote:
> > Hello Ard,
> > 
> > On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > > I don't see how this could be an EFI bug, given that it does not
> > > deal with E820 tables at all.
> > 
> > I want to back up a little bit and make sure I am following the
> > discussion.
> > 
> > From what I understand from previous discussion, we have an EFI bug
> > as the root cause of this issue.
> > 
> > This happens because the EFI does NOT mark the EFI TPM event log
> > memory region as reserved (EFI_RESERVED_TYPE). Not having an entry
> > for the event table memory in EFI memory mapped, then libstub will
> > ignore it completely (the TPM event log memory range) and not
> > populate e820 table with it.
> 
> Wait, that's not correct.  The TPM log is in memory that doesn't
> survive ExitBootServices (by design in case the OS doesn't care about
> it).  So the EFI stub actually copies it over to a new configuration
> table that is in reserved memory before it calls ExitBootServices. 
> This new copy should be in kernel reserved memory regardless of its
> e820 map status.

First of all, thanks for clarifying some points here.

How should the TPM log table be passed to the next kernel when
kexecing() since it didn't surive ExitBootServices?

