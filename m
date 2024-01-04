Return-Path: <linux-efi+bounces-337-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C56824AED
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 23:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7880228515C
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93DF286B0;
	Thu,  4 Jan 2024 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScnU/miw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141D2C6A6;
	Thu,  4 Jan 2024 22:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDACC433C7;
	Thu,  4 Jan 2024 22:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704407847;
	bh=02xdEvkQgxl0QgYG12fhILXcS05r5JkyWJF03KY5he4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ScnU/miwdyVdmnQmUzdZjXLnbm15i7VEprvnkOTjtX5Al9T7AYsa7YgmbPx5nvJFc
	 GEueXE2WQxaJXM7k20zgCUnVgMkXS8mEU9lTp2tdw+pOq0CblbrOMB+UyNwZoy1Ifs
	 2dzwv+SdihVFpfz9+LIyqki5krAbyzeyel2w/XTbyoc0HC6B1+tvRSjZkfVAbNQzxC
	 NZQFAVEOwbbGersZbL/sWe13DsS7BzJhhL5KiFhpnTOmSbUWbmTChbzQJ4QkTeYwJY
	 pr48rtHHAOJfA+yt2gNS4WnRGY8oDGkZmUXHVgtSThtdgticui7BVn52DABqJ3B104
	 6M7Y46I85QToA==
Date: Thu, 4 Jan 2024 16:37:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20240104223725.GA1829769@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6597275045fbf_267e82949d@iweiny-mobl.notmuch>

On Thu, Jan 04, 2024 at 01:46:56PM -0800, Ira Weiny wrote:
> Dan Williams wrote:
> > Bjorn Helgaas wrote:
> > [..]
> > > > ---
> > > > PCI: Introduce cleanup helpers for device reference counts and locks
> > > > 
> > > > The "goto error" pattern is notorious for introducing subtle resource
> > > > leaks. Use the new cleanup.h helpers for PCI device reference counts and
> > > > locks.
> > > > 
> > > > Similar to the new put_device() and device_lock() cleanup helpers,
> > > > __free(put_device) and guard(device), define the same for PCI devices,
> > > > __free(pci_dev_put) and guard(pci_dev).  These helpers eliminate the
> > > > need for "goto free;" and "goto unlock;" patterns. For example, A
> > > > 'struct pci_dev *' instance declared as:
> > > > 
> > > > 	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> > > 
> > > I see several similar __free() uses with NULL initializations in gpio,
> > > but I think this idiom would be slightly improved if the __free()
> > > function were more closely associated with the actual pci_dev_get():
> > > 
> > >   struct pci_dev *pdev __free(pci_dev_put) = pci_get_device(...);
> > > 
> > > Not always possible, I know, but easier to analyze when it is.
> > 
> > I tend to agree, but it does lead to some long lines, for example:
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 4fd1f207c84e..549ba4b8294e 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -975,15 +975,14 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
> >  				struct cxl_cper_event_rec *rec)
> >  {
> >  	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> > -	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> >  	enum cxl_event_log_type log_type;
> >  	struct cxl_dev_state *cxlds;
> >  	unsigned int devfn;
> >  	u32 hdr_flags;
> >  
> >  	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> > -	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> > -					   device_id->bus_num, devfn);
> > +	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
> > +		device_id->segment_num, device_id->bus_num, devfn);
> >  	if (!pdev)
> >  		return;
> >  
> > ...so I think people are choosing the "... __free(x) = NULL;" style for
> > code density readability.
> > 
> 
> Also in this case we need devfn assigned first.
> 
> Is the above patch compliant with current style guidelines?
> 
> Or would it be better to do?
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b14237f824cf..8a180c6abb67 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -975,15 +975,14 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
>                                 struct cxl_cper_event_rec *rec)
>  {
>         struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> -       struct pci_dev *pdev __free(pci_dev_put) = NULL;
>         enum cxl_event_log_type log_type;
>         struct cxl_dev_state *cxlds;
> -       unsigned int devfn;
> +       unsigned int devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> +       struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
> +                                                       device_id->segment_num,
> +                                                       device_id->bus_num, devfn);

I don't really care about this specific instance; my comment was more
about the commit log for the "Define scope based management functions"
patch, thinking maybe the example could encourage get/put togetherness
when it's practical.

Bjorn

