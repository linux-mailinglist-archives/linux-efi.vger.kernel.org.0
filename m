Return-Path: <linux-efi+bounces-318-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDC68238DF
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 00:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77D41C2476D
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7239D1DDEA;
	Wed,  3 Jan 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZdPlows"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B71DDE6;
	Wed,  3 Jan 2024 23:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8206CC433C8;
	Wed,  3 Jan 2024 23:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704322908;
	bh=KIH/kxO3N+Os8WnlfgT8ax5cLQr2L2egFhTNUTO9ulM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DZdPlowsvov65k9D9B7URnlt/esrBDhGSXzmr1P9ZWAwPs+/H1c/EPu0KEyLY/HRh
	 6nMx1exvU9cDAYxxaizA6aWe1qDoSkQ2BqCMihwE8TYJlo5NaR0P76L/3YWR/IKCdS
	 veCzh7tt+ap5HD5kiol177H/c/CKLj81MliYcGuC8dECuJXm8j3rrafk5VJyLY1GWP
	 Krn65x7Zn3P4LjzMlj3+lvcw2DWKl8it1zXgPjNlqJPGXmMYy2CpoAKFewm/sNQPkw
	 EwEElxDMBD0Mcw0QIEY4FoVgzi6kDkBcM1xGWLt8I/emXyXrIc0S1B7JiZxgP+eesW
	 HmNykZHFR4+bQ==
Date: Wed, 3 Jan 2024 17:01:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <20240103230147.GA1800245@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6595e201beb4_be7022944d@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jan 03, 2024 at 02:38:57PM -0800, Dan Williams wrote:
> Ira Weiny wrote:
> > Users of pci_dev_get() can benefit from a scoped based put.  Also,
> > locking a PCI device is often done within a single scope.
> > 
> > Define a pci_dev_put() free function and a PCI device lock guard.  These
> > will initially be used in new CXL event processing code but is defined
> > in a separate patch for others to pickup and use/backport easier.
> 
> Any heartburn if I take this through cxl.git with the rest in this
> series? Patch 9 has a dependency on this one.

No real heartburn.  I was trying to figure out what this does
since I'm not familiar with the "scoped based put" idea and
'git grep -i "scope.*base"' wasn't much help.

I would kind of like the commit log to say a little more about what
the "scoped based put" (does that have too many past tenses in it?)
means and how users of pci_dev_get() will benefit.

I don't know what "locking a PCI device is often done within a single
scope" is trying to tell me either.  What if it's *not* done within a
single scope?

Does this change anything for callers of pci_dev_get() and
pci_dev_put()?

Does this avoid a common programming error?  I just don't know what
the benefit of this is yet.

I'm sure this is really cool stuff, but there's little documentation,
few existing users, and I don't know what I need to look for when
reviewing things.

> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
> >  u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
> >  struct pci_dev *pci_dev_get(struct pci_dev *dev);
> >  void pci_dev_put(struct pci_dev *dev);
> > +DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
> >  void pci_remove_bus(struct pci_bus *b);
> >  void pci_stop_and_remove_bus_device(struct pci_dev *dev);
> >  void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
> > @@ -1871,6 +1872,7 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
> >  void pci_dev_lock(struct pci_dev *dev);
> >  int pci_dev_trylock(struct pci_dev *dev);
> >  void pci_dev_unlock(struct pci_dev *dev);
> > +DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
> >  
> >  /*
> >   * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
> > 
> > -- 
> > 2.43.0
> > 
> 
> 

