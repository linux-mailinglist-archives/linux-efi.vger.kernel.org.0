Return-Path: <linux-efi+bounces-4518-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E3B1EB1F
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 17:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58381C26E0D
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2891E280CC9;
	Fri,  8 Aug 2025 15:01:32 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E954279;
	Fri,  8 Aug 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665292; cv=none; b=gl1n81Q3AVPxjj75s6cqGSAWIUkl/YfW07RGkI/SArJDTdxSkbJrdE/hiFBpRpeMlj0/PwhGY4dJhZkcXlpxOeQ+cbawwNaEBV0bSDywSLDNSkbY6At+r9DkOUZA7hF5L1oWmvqGme3O3n38OoL4AoY5AxNE8geKX3UpwJY5GGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665292; c=relaxed/simple;
	bh=nuupsZc8RG3tNebJl+SLG2dA8VB8Aqfq0h2wAajCpEQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZMNGwHRa4HoG2GOvM48dAyMgZeNF6AN/PNW1e/NdNHavpULIZmsJN261GGdhYLcNMZZNczyfTdlEjfri+6rJrj2bQR5swjXG6elImKaXw/jqOyZ6ItEVAdBWYIelnT9vsL5cOXopeIV4oSab4XWwbhLr775YCN4x9uBiRL5i8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz6d33rXNz6M4Lv;
	Fri,  8 Aug 2025 22:59:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B9240140446;
	Fri,  8 Aug 2025 23:01:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 17:01:22 +0200
Date: Fri, 8 Aug 2025 16:01:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "James
 Morse" <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-edac@vger.kernel.org>, Jason Tian
	<jason@os.amperecomputing.com>, Shengwei Luo <luoshengwei@huawei.com>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 0/5] Fix issues with ARM Processor CPER records
Message-ID: <20250808160121.000038bd@huawei.com>
In-Reply-To: <385eca9a-0366-4f3a-95cf-6f19101957ea@os.amperecomputing.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
	<385eca9a-0366-4f3a-95cf-6f19101957ea@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 5 Aug 2025 11:39:38 -0700
Daniel Ferguson <danielf@os.amperecomputing.com> wrote:

> On 8/5/2025 11:35 AM, Daniel Ferguson wrote:
> > [NO NEED FOR INTERNAL REVIEW, THIS IS JUST A TEST]  
> 
> Yes, PLEASE REVIEW...
> I accidentally left that message in...
> 
> ~Daniel

Hi Daniel,

No problem with you picking this up to take forwards as I gather you asked
Mauro first, but good to mention that change and that it's with agreement
(or not if it's abandoned code which I don't think this was.) 

Thanks,

Jonathan

