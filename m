Return-Path: <linux-efi+bounces-355-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9839B827021
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 14:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1B71C228E8
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD37B44C8F;
	Mon,  8 Jan 2024 13:44:05 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E245944;
	Mon,  8 Jan 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7wFh3KSQz67MmR;
	Mon,  8 Jan 2024 21:41:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 725321400D9;
	Mon,  8 Jan 2024 21:44:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 13:44:00 +0000
Date: Mon, 8 Jan 2024 13:44:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <20240108134400.00001357@Huawei.com>
In-Reply-To: <20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
	<20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 20 Dec 2023 16:17:35 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Users of pci_dev_get() can benefit from a scoped based put.  Also,
> locking a PCI device is often done within a single scope.
> 
> Define a pci_dev_put() free function and a PCI device lock guard.  These
> will initially be used in new CXL event processing code but is defined
> in a separate patch for others to pickup and use/backport easier.
> 
> Cc: Bjorn Helgaas      <bhelgaas@google.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

With the extra text buried deep in the discussion LGTM.
I've not been that thorough on documenting my own similar cleanup.h
series, so might well steal some of that for the ones I have outstanding
for device_handle_put() and fwnode_handle_put() ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes for v5:
> [Jonathan: New patch]
> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60ca768bc867..290d0a2651b2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
>  u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
>  struct pci_dev *pci_dev_get(struct pci_dev *dev);
>  void pci_dev_put(struct pci_dev *dev);
> +DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
>  void pci_remove_bus(struct pci_bus *b);
>  void pci_stop_and_remove_bus_device(struct pci_dev *dev);
>  void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
> @@ -1871,6 +1872,7 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
>  void pci_dev_lock(struct pci_dev *dev);
>  int pci_dev_trylock(struct pci_dev *dev);
>  void pci_dev_unlock(struct pci_dev *dev);
> +DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
>  
>  /*
>   * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
> 


