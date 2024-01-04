Return-Path: <linux-efi+bounces-334-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A58824838
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 19:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BB61F23482
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541BA28E09;
	Thu,  4 Jan 2024 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnocWM5g"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB02C19C;
	Thu,  4 Jan 2024 18:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C40C433C8;
	Thu,  4 Jan 2024 18:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704393141;
	bh=6F/ke4aUVOdLoQLcL8fnnAuHNimJm5rztZMuCz1zKwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EnocWM5gleikzv5q0S6ZqkL0CCW31N63mlxKE3kzYthnGpAeVicfp5lf6/0niTXdI
	 2D9WXsnaFYqlIntsQ3d0J2RJzhb2sx3NRzzkj1ySr1GVbol4TBDneBCgs+yBirIXY7
	 dtt/QaprNlSZWmZXCgcLn09UeyRp5QE0GRqFlPKZMBr0qsxjMY3alZv6b0bhHclLBT
	 adO7bp3lNWJrv94FpFQla+XyuAPi03WBX/zUgX/apegSKrZC2VfPicSmJYNSdr19iM
	 G9qcuUqe6iYOmMKVd/Hq2OJ5imkjyhXNjXpBnkS/SUfmQciLC85otdS0Cn2/KskOrb
	 Vtj5V6/4WH7lg==
Date: Thu, 4 Jan 2024 12:32:18 -0600
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
Message-ID: <20240104183218.GA1820872@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6595f9eec5986_be70229443@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jan 03, 2024 at 04:21:02PM -0800, Dan Williams wrote:
> Bjorn Helgaas wrote:
> > On Wed, Jan 03, 2024 at 02:38:57PM -0800, Dan Williams wrote:
> > > Ira Weiny wrote:
> > > > Users of pci_dev_get() can benefit from a scoped based put.  Also,
> > > > locking a PCI device is often done within a single scope.
> > > > 
> > > > Define a pci_dev_put() free function and a PCI device lock guard.  These
> > > > will initially be used in new CXL event processing code but is defined
> > > > in a separate patch for others to pickup and use/backport easier.
> > > 
> > > Any heartburn if I take this through cxl.git with the rest in this
> > > series? Patch 9 has a dependency on this one.
> > 
> > No real heartburn.  I was trying to figure out what this does
> > since I'm not familiar with the "scoped based put" idea and
> > 'git grep -i "scope.*base"' wasn't much help.
> > 
> > I would kind of like the commit log to say a little more about what
> > the "scoped based put" (does that have too many past tenses in it?)
> > means and how users of pci_dev_get() will benefit.
> 
> That is completely fair, and I should have checked to make sure that the
> changelog clarified the impact of the change.

I see "scoped based put" follows a similar use in cleanup.h, but I
think "scope-based X" reads better.

> > I don't know what "locking a PCI device is often done within a single
> > scope" is trying to tell me either.  What if it's *not* done within a
> > single scope?
> > 
> > Does this change anything for callers of pci_dev_get() and
> > pci_dev_put()?
> > 
> > Does this avoid a common programming error?  I just don't know what
> > the benefit of this is yet.
> > 
> > I'm sure this is really cool stuff, but there's little documentation,
> > few existing users, and I don't know what I need to look for when
> > reviewing things.
> 
> Here a is a re-write of the changelog:
> 
> ---
> PCI: Introduce cleanup helpers for device reference counts and locks
> 
> The "goto error" pattern is notorious for introducing subtle resource
> leaks. Use the new cleanup.h helpers for PCI device reference counts and
> locks.
> 
> Similar to the new put_device() and device_lock() cleanup helpers,
> __free(put_device) and guard(device), define the same for PCI devices,
> __free(pci_dev_put) and guard(pci_dev).  These helpers eliminate the
> need for "goto free;" and "goto unlock;" patterns. For example, A
> 'struct pci_dev *' instance declared as:
> 
> 	struct pci_dev *pdev __free(pci_dev_put) = NULL;

I see several similar __free() uses with NULL initializations in gpio,
but I think this idiom would be slightly improved if the __free()
function were more closely associated with the actual pci_dev_get():

  struct pci_dev *pdev __free(pci_dev_put) = pci_get_device(...);

Not always possible, I know, but easier to analyze when it is.

> ...will automatically call pci_dev_put() if @pdev is non-NULL when @pdev
> goes out of scope (automatic variable scope). If a function wants to
> invoke pci_dev_put() on error, but return @pdev on success, it can do:
> 
> 	return no_free_ptr(pdev);
> 
> ...or:
> 
> 	return_ptr(pdev);
> 
> For potential cleanup opportunity there are 587 open-coded calls to
> pci_dev_put() in the kernel with 65 instances within 10 lines of a goto
> statement with the CXL driver threatening to add another one.
> 
> The guard() helper holds the associated lock for the remainder of the
> current scope in which it was invoked. So, for example:
> 
> 	func(...)
> 	{
> 		if (...) {
> 			...
> 			guard(pci_dev); /* pci_dev_lock() invoked here */
> 			...
> 		} /* <- implied pci_dev_unlock() triggered here */
> 	}

Thanks for this!  I had skimmed cleanup.h previously, but it makes a
lot more sense after your description here.  

I think a little introduction along these lines would be even more
useful in cleanup.h since the concept is general and not PCI-specific.
E.g., the motivation (avoid resource leaks with "goto error" pattern),
a definition of "__free() based cleanup function" (IIUC, a function to
be run when a variable goes out of scope), maybe something about
ordering (it's important in the "goto error" pattern that the cleanups
are done in a specific order; how does that translate to __free()?)

But the commit log above is fine with me.  (It does contain tabs,
which get slightly mangled when "git log" indents it.)

> There are 15 invocations of pci_dev_unlock() in the kernel with 5
> instances within 10 lines of a goto statement. Again, the CXL driver is
> threatening to add another.
> 
> Introduce these helpers to preclude the addition of new more error prone
> goto put; / goto unlock; sequences. For now, these helpers are used in
> drivers/cxl/pci.c to allow ACPI error reports to be fed back into the
> CXL driver associated with the PCI device identified in the report.

This part is also fine but doesn't seem strictly necessary to me.  I
think the part about error reports being fed back needs a lot more
background to understand the connection, and probably only makes sense
in the context of that patch.

> As for reviewing conversions that use these new helpers, one of the
> gotchas I have found is that it is easy to make a mistake if a goto
> still exists in the function after the conversion. So unless and until
> all of the resources a function acquires, that currently need a goto to
> unwind them on error, can be converted to cleanup.h based helpers it is
> best not to mix styles.
> 
> I think the function documentation in include/linux/cleanup.h does a
> decent job of explaining how to use the helpers. However, I am happy to
> suggest some updates if you think it would help.

Thanks, Dan!

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

