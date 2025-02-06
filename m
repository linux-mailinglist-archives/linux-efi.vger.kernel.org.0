Return-Path: <linux-efi+bounces-2757-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55925A2A657
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 11:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90D7167E98
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A662288D6;
	Thu,  6 Feb 2025 10:54:16 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948D22759D;
	Thu,  6 Feb 2025 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839256; cv=none; b=CNRtJsEsSBngTjL4j53ssBpj3viNQCuBpLxxdMAbn4u33PAq/jFT+fbiua7B9uXsoEBtG7voZ8xd9yZIB4nzraEJ9EHFOcM+bDjPqEceFlDhz5xW7u+/IVglAOK44xxkfTzAh2uqNGxrJS0BEYmbSSOtNysLxSvzCrojkFXh8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839256; c=relaxed/simple;
	bh=JsxwIqP/N+Apmy+QdOX3v7imX3A6loX8bvM9cfenOMA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooFVZ+WNe7vt4GHFedRtu+WZNVkWbpovS+EdoJ7ugHZcOpAn97AFWEIHcb4xXjvOksZ2vl3tHYfbV7IjtDNnunRRtwFcSDC78wI9rPp/mhqSPs11n4XYmWWZy4xW+YO0cN5jblKVHixCtcHbSMAWUlc5X3StHEOOu35cWoh32bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YpYnc26v2z67LmL;
	Thu,  6 Feb 2025 18:51:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5680D140525;
	Thu,  6 Feb 2025 18:54:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Feb
 2025 11:54:04 +0100
Date: Thu, 6 Feb 2025 10:54:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <20250206105403.00007062@huawei.com>
In-Reply-To: <Z6O5JqL30lFr4S8Q@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
	<20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
	<Z6O5JqL30lFr4S8Q@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Feb 2025 14:16:54 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Jan 23, 2025 at 08:44:17AM +0000, Smita Koralahalli wrote:
> > In preparation to add tracepoint support, move protocol error UUID
> > definition to a common location, Also, make struct CXL RAS capability,
> > cxl_cper_sec_prot_err and CPER validation flags global for use across
> > different modules.
> > 
> > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>  
> 
> Reveiwed-by: Gregory Price <gourry@gourry.net>

Reviewed...

If Dave picks this up will need to tweak that.
> 


