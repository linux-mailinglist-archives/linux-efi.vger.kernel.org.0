Return-Path: <linux-efi+bounces-1182-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655CE900868
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2024 17:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15392284C4C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2024 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B31993AE;
	Fri,  7 Jun 2024 15:14:46 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BA1993AB;
	Fri,  7 Jun 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773286; cv=none; b=FFPSoGQ/PAownF1mK5glG1gnV/ndSt1l4H+v3dTaa6JMPenvXrnm/yFVZjVp9Sgiht3S8JrRKsU8Jcju+PvhZrjbJLMV3mSya74cDbzq9Xnx7tUqV9N1UT9HEsZznoZBo0JCERElsTbvFlJvtwxrfv9b9ZHKfrPp00RN0fkxBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773286; c=relaxed/simple;
	bh=R9Se83mu+laLM1rCrSp02Y7FzdT83sdjKO0Skp+kNuo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk4bcGuEAmNdySgxXA+r4q/Cmsmevo/wyw9e3gwj3GlhAJb6QJrWrrSDkRMoEMLtBCmEngLJW3rbDPaJ3aNxAiqi89PIQo+DpwcvnbxsnLaIqf53f/a3qPwyWnhveTfK/R9sX0rf/Llb3eI6nNaBxftp15Qq61mgCT0uJWkf6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwl463gK6z6G9F8;
	Fri,  7 Jun 2024 23:09:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C1AA1400CD;
	Fri,  7 Jun 2024 23:14:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 16:14:40 +0100
Date: Fri, 7 Jun 2024 16:14:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Bowman
 Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH 1/4] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <20240607161439.0000030c@Huawei.com>
In-Reply-To: <20240522150839.27578-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
	<20240522150839.27578-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 22 May 2024 15:08:36 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location and make CXL RAS capability struct
> global for use across different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
FWIW given already well reviewed.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


