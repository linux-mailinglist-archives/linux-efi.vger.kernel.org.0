Return-Path: <linux-efi+bounces-4526-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B14B1F54A
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F4F3B26F7
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BCF2BE62A;
	Sat,  9 Aug 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeYIrzw6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1812E5B;
	Sat,  9 Aug 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754754555; cv=none; b=Q85ULHhqWz6axg/pxnC/FAw/0ptUaoWgqTJZNSevxZKfYoeIgKdd+1BNRUJMWEsKXsJADJFjWphf08qXkH3I2MLW7GGgx/lDcndF6IIes5YCo5zeCPS8y8I5rt6jooqXhIDNVk4i4ohFRajO0GCYYj3LDjkGnLkvxkgHQ0NmGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754754555; c=relaxed/simple;
	bh=7vhXrSuioZ/SBtRU3dtiWP/UxtiLm+RnSM/SUhZhUWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU1VMu81My+mQperQqulzARGYtNEl7TWr9GsjF6d8qrYVJDOLtQY0wU125DbS4X4Zj18SM9Yd5FOX8f8EMHmv2By5kGUlrp1WCAs5nVujoCBhFIgAae0i8yhWB+OjgQzmKvBZ+h6uokeAkKu6+FPgFMOdheK11PkOBAe3UcZtKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeYIrzw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72998C4CEE7;
	Sat,  9 Aug 2025 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754754553;
	bh=7vhXrSuioZ/SBtRU3dtiWP/UxtiLm+RnSM/SUhZhUWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AeYIrzw6PnujYHIivdpprLbCVBJJQp2fdEyQ/xsD8jKikwQylgzqARsMFhU4EykU0
	 W5jg9ied0X6sycGDiIx01KFxiMu7ItlFTXRp0deBctpVieEd32qgOTqHrE7Y4f7Okr
	 GcD2ys0L+RAPxYbTqF/6VIDO1Cy8UOhossFxGz4xtzAmQoBo4ORBEJGCUsko7ZPqGj
	 pc1iLL3cHLrnZaQtW94TafVbpN2K3cK/32KxpNnKWPzU62xKZTRoDnKGPPtVKj8anp
	 lFD9tsYVUBxhfcBIToO7SlzgUGhhvQ8W3ThB6yqPf5NS7ATMeS5hoPLEdJqQROTaU5
	 +ANpyaud/Ckiw==
Date: Sat, 9 Aug 2025 17:49:07 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Daniel Ferguson <danielf@os.amperecomputing.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ard Biesheuvel
 <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
 <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
 <bp@alien8.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-edac@vger.kernel.org, Jason Tian <jason@os.amperecomputing.com>,
 Shengwei Luo <luoshengwei@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH v4 0/5] Fix issues with ARM Processor CPER records
Message-ID: <20250809174907.35ac47c5@foz.lan>
In-Reply-To: <4499042f-e1e0-4fe6-8670-4556a3f4a88a@os.amperecomputing.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
	<385eca9a-0366-4f3a-95cf-6f19101957ea@os.amperecomputing.com>
	<20250808160121.000038bd@huawei.com>
	<4499042f-e1e0-4fe6-8670-4556a3f4a88a@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 8 Aug 2025 12:03:06 -0700
Daniel Ferguson <danielf@os.amperecomputing.com> escreveu:

> On 8/8/2025 8:01 AM, Jonathan Cameron wrote:
> > On Tue, 5 Aug 2025 11:39:38 -0700
> > Daniel Ferguson <danielf@os.amperecomputing.com> wrote:
> >   
> >> On 8/5/2025 11:35 AM, Daniel Ferguson wrote:  
> >>> [NO NEED FOR INTERNAL REVIEW, THIS IS JUST A TEST]    
> >>
> >> Yes, PLEASE REVIEW...
> >> I accidentally left that message in...
> >>
> >> ~Daniel  
> > 
> > Hi Daniel,
> > 
> > No problem with you picking this up to take forwards as I gather you asked
> > Mauro first, but good to mention that change and that it's with agreement
> > (or not if it's abandoned code which I don't think this was.) 
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Hi Jonathan,
> 
> I didn't ask Mauro directly, but I did ask this list if my intervention would be
> useful. I was given feedback that it would be.
> 
> When I resubmit this patch, to take into account your feedback, I'll be sure to
> also explain in the cover letter the change of hands.

I saw your past e-mail. I'm fine if you can resubmit this.

> 
> Hopefully I didn't step on any toes, that wasn't my intention.
> 
> FWIW, here is a link to the brief conversation that led to the hand-off:
> https://lore.kernel.org/linux-acpi/CAMj1kXGSNT08QrCp1jazmi9ANpZ7RCuS4kHo9x6hwxtp6z0Nhg@mail.gmail.com/

Regards,
Mauro

