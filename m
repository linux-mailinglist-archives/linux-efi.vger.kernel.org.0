Return-Path: <linux-efi+bounces-322-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61286823C6F
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 08:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BA728839F
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980151A70D;
	Thu,  4 Jan 2024 07:02:39 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E561D699;
	Thu,  4 Jan 2024 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8489130000D0B;
	Thu,  4 Jan 2024 08:02:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 67757239FE7; Thu,  4 Jan 2024 08:02:35 +0100 (CET)
Date: Thu, 4 Jan 2024 08:02:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>,
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
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <20240104070235.GA13468@wunner.de>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com>
 <20240104060528.GA10504@wunner.de>
 <6596539c9729e_8dc6829476@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6596539c9729e_8dc6829476@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 03, 2024 at 10:43:40PM -0800, Dan Williams wrote:
> Lukas Wunner wrote:
> > On Wed, Dec 20, 2023 at 04:17:35PM -0800, Ira Weiny wrote:
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
> > >  u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
> > >  struct pci_dev *pci_dev_get(struct pci_dev *dev);
> > >  void pci_dev_put(struct pci_dev *dev);
> > > +DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
> > 
> > pci_dev_put() already performs a NULL pointer check internally.
> > Why duplicate it here?
> 
> Greg asked the same for the introduction of __free(kvfree), and Peter
> clarified:
> 
> http://lore.kernel.org/r/20230814161731.GN776869@hirez.programming.kicks-ass.net
> 
> Essentially, that check is more for build-time than runtime because when
> the macro is expanded the compiler can notice scenarios where @pdev is
> set to NULL (likely by no_free_ptr()) and skip the call to pci_dev_put()
> altogether. pci_dev_put() also happens to be out-of-line, so saving a
> call when @pdev is NULL a small win in that respect as well.

Doubtful whether that's correct.  The kernel is compiled with
-fno-delete-null-pointer-checks since commit a3ca86aea507
("Add '-fno-delete-null-pointer-checks' to gcc CFLAGS").

So these NULL pointer checks are generally not optimized away.

I've just responded to the discussion you've linked above:
https://lore.kernel.org/all/20240104065744.GA6055@wunner.de/

Thanks,

Lukas

