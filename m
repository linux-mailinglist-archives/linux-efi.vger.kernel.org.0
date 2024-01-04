Return-Path: <linux-efi+bounces-323-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE3823CD0
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 08:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C81B21078
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF761EB42;
	Thu,  4 Jan 2024 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwubNwgj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98CE15EA6;
	Thu,  4 Jan 2024 07:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51099C433C8;
	Thu,  4 Jan 2024 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704353856;
	bh=atAczvBpbmGSvkt1pg+/6q2+kUOQhOSbBRS7ljsGUqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GwubNwgjwG0q2RuxyiLvmP9xIKpTZYhvf8OYSsdMEleUGDlxrFnT83li2NF6S3Hz9
	 JWWXUEv8aqsB3S8ZamxNA9x1Tfuu9RZ8/HDrUgkhYE46hNatUdUXA0el9f5T9LiukR
	 CVfJUyx/QG/OJfZlRdOhomU1q0fQEm9reN7/wTvhGVDaTnQVW7MSx4HGY7Gjthnt3d
	 sNlMMn0Ta7gnjYHV752I4Kty1KIW2utSEg8yIlJS/PYnXGFtYwF7x+7rqj7lrvme/e
	 LbijIPLPnFmYSmGpPoiLDwaxn/j5BRgQuQBZVKEaM8iaGvwzUB4xTR9FP36XI7k4Gl
	 VwNHKgZxPBmaA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so210762e87.2;
        Wed, 03 Jan 2024 23:37:36 -0800 (PST)
X-Gm-Message-State: AOJu0YzvMvph01jSVlEzGcKku9osLp+PcILUoc6j/bg292BFOfYI6uW8
	wn0xU3MkLymzEaNUrMIb2Xg8ZXzsjtPSQAFO7cQ=
X-Google-Smtp-Source: AGHT+IFmREZau6p3FF5i1IODQb129a2+sQctrxPIwV1EN77X8L7RQcox83dtwDiy6GAjhLisb9k8VEpAjECV2P/8HAQ=
X-Received: by 2002:ac2:5504:0:b0:50e:aa46:7576 with SMTP id
 j4-20020ac25504000000b0050eaa467576mr94689lfk.7.1704353854547; Wed, 03 Jan
 2024 23:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com> <20240104060528.GA10504@wunner.de>
 <6596539c9729e_8dc6829476@dwillia2-xfh.jf.intel.com.notmuch> <20240104070235.GA13468@wunner.de>
In-Reply-To: <20240104070235.GA13468@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Jan 2024 08:37:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG0QiizpA_oTkV4h2DaF4KuM454_KBno3UngvO7fRm-7g@mail.gmail.com>
Message-ID: <CAMj1kXG0QiizpA_oTkV4h2DaF4KuM454_KBno3UngvO7fRm-7g@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
To: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 08:02, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, Jan 03, 2024 at 10:43:40PM -0800, Dan Williams wrote:
> > Lukas Wunner wrote:
> > > On Wed, Dec 20, 2023 at 04:17:35PM -0800, Ira Weiny wrote:
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
> > > >  u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
> > > >  struct pci_dev *pci_dev_get(struct pci_dev *dev);
> > > >  void pci_dev_put(struct pci_dev *dev);
> > > > +DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
> > >
> > > pci_dev_put() already performs a NULL pointer check internally.
> > > Why duplicate it here?
> >
> > Greg asked the same for the introduction of __free(kvfree), and Peter
> > clarified:
> >
> > http://lore.kernel.org/r/20230814161731.GN776869@hirez.programming.kicks-ass.net
> >
> > Essentially, that check is more for build-time than runtime because when
> > the macro is expanded the compiler can notice scenarios where @pdev is
> > set to NULL (likely by no_free_ptr()) and skip the call to pci_dev_put()
> > altogether. pci_dev_put() also happens to be out-of-line, so saving a
> > call when @pdev is NULL a small win in that respect as well.
>
> Doubtful whether that's correct.  The kernel is compiled with
> -fno-delete-null-pointer-checks since commit a3ca86aea507
> ("Add '-fno-delete-null-pointer-checks' to gcc CFLAGS").
>
> So these NULL pointer checks are generally not optimized away.
>
> I've just responded to the discussion you've linked above:
> https://lore.kernel.org/all/20240104065744.GA6055@wunner.de/
>

AIUI, Peter is referring to constant propagation of compile time
constant pointers here, not pointer variables where the NULL check is
elided if the variable has already been dereferenced.

