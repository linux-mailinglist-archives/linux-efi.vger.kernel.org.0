Return-Path: <linux-efi+bounces-3079-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81620A70185
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 14:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACC217A02F
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33525A2C5;
	Tue, 25 Mar 2025 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIoJu7Mp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994E25A2C4
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907560; cv=none; b=bxRVLiLRFxZg5z/JMeKjCKLkNSAgsI4PYcTjN0k/WswzAiTMkOC2DuW26mZ1VmRHwfdfnxkXippv60wXUS/kJI4NbQy1BRBJaagqSnptHHCRxfVg3z3TkxLkeomfZMsgPQBE8l9sjk/M/Pu7GhystnoK7ZTFuCKeB5HpNaqNv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907560; c=relaxed/simple;
	bh=uYj5JSBKs50NEfFYv0rVY3PHNQZuN7UZ4x25AKHeskw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8oDks6o5tkIWpIHl3AXpoYR9njYcBWUDHcdtcOfloVaeW9fsVQGU/ntPbqDW/klMV7tIgiCW1Csh5XpioO/o9QfGQ7ih2bSBwIaLrBB6kFNBEEOqfdnWrIcM8k45/f108FCVuBgfhi99zxv6oseLcV2ocjAVDvd36tvZLFNaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIoJu7Mp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742907559; x=1774443559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYj5JSBKs50NEfFYv0rVY3PHNQZuN7UZ4x25AKHeskw=;
  b=gIoJu7MpS9vZmT2mkb/AcITb/tE2/H4p1NunSl+4z+fNb+lOvAID40lS
   3OKw4bDYq0xP4GE5SNDu9m+OQI/w3KJGKdHQaECkTtb2MYOL0lPlWzd4a
   4jBkV/T9OzTol7F+l7r8ZA562OleZVoznKnKH2YFm1VN/sBoaRyelh0me
   vMi/7E0QDUPm0GvWfO6ODWDdzY3VWeDPQlxb3SZ6ldEj6zWOVuDKlUPeR
   AKjCqcxC0sfCl3COIn6OoajO3dvUeMVnmPOg+JHM+Cqq1dfiXVFwpDge9
   OjU3bT+zqtMU+7WTiq8Q0jQnBQe5nWJ+6zDMG1FJ13QEkUg0YREdPVoB1
   g==;
X-CSE-ConnectionGUID: NiyCuY+QT8mpd/J8aIKWkA==
X-CSE-MsgGUID: g8kvw15KQdqcDuwAlEnnIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43877033"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="43877033"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 05:59:19 -0700
X-CSE-ConnectionGUID: uQT/5C6PR7OL6E1PzLEY2g==
X-CSE-MsgGUID: Kl6v3K3vQyOXX2xbkfL9kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="161581346"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 25 Mar 2025 05:59:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 75CEF367; Tue, 25 Mar 2025 14:59:15 +0200 (EET)
Date: Tue, 25 Mar 2025 14:59:15 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-coco@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before
 ExitBootServices()
Message-ID: <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
References: <20250325091614.1203411-2-ardb+git@google.com>
 <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
 <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>

On Tue, Mar 25, 2025 at 01:41:04PM +0100, Ard Biesheuvel wrote:
> On Tue, 25 Mar 2025 at 13:36, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Tue, Mar 25, 2025 at 10:16:15AM +0100, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Currently, setup_e820() in the x86 EFI stub records unaccepted memory in
> > > the associated bitmap, which has a 2 MiB granularity. To avoid
> > > ambiguities, any unaccepted region that is not aligned to 2 MiB will be
> > > partially accepted upfront, so that all regions recorded into the bitmap
> > > are aligned to the bitmap's granularity.
> > >
> > > On SEV-SNP, this results in calls into the SEV support code before it is
> > > initialized, and crucially, before ExitBootServices() is called, which
> > > means that the firmware is still in charge at that point, and
> > > initializing the SEV support code is not even permitted.
> > >
> > > So instead, round the unaccepted regions outwards, so that all
> > > unaccepted memory is recorded as such in the bitmap, along with possibly
> > > some pages that have already been accepted. This is less efficient in
> > > theory, but should rarely occur -and therefore not matter- in practice.
> >
> > NAK.
> >
> > It opens us for double-accept attacks:
> >
> > https://lore.kernel.org/all/zuz27i7ffrsa3hksveuroxpwxos5qx65py23gvupaadizwrsss@uhb6ye4j2eqn/
> >
> 
> So what fix are you proposing? The code is currently broken.

I don't know SEV specifics, but I wounder how BIOS itself accepts the
memory?

Since the problem happens before ExitBootServices(), can we allocate this
memory range with EFI API and free it back?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

