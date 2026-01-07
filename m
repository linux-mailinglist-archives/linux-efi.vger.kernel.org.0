Return-Path: <linux-efi+bounces-5956-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F22CFF348
	for <lists+linux-efi@lfdr.de>; Wed, 07 Jan 2026 18:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98A6F3004F3C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jan 2026 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E2393DCB;
	Wed,  7 Jan 2026 17:53:24 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD0389DEE;
	Wed,  7 Jan 2026 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808403; cv=none; b=r9CWY2wuheX+Hdg8s5YX77Imj+UOrDZnAvtU9lhNULt9VIKtLwANEyQjGcRxsSZG6M9wqshP/rEJexrS+JaKMuoteFkCZGy97Iia20SPF52JQMsuZ9Qz+jxzvDzn0AZlHznAKbebNdg5UL3JVNA/VhcXlD3+WVx2oiFgOPnSSdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808403; c=relaxed/simple;
	bh=Y2G1yfild1lPoae/gx3z2twuVbSyj4sr+CGM83xRXRY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVjoEqydscmbRGz0W7+lolKmpfMQHa0tZjcSnTeobzstKKdKyfXBxKkzg9WwBkDjw2N/qxb1W/vMLV1FdvnSraV6b1DzLkdoDdfPrcBFAf9mdj38FXtmqXuI6Yvr+mdjED22jpSiLP0adqG1krtUaST3n/syAESE8UJlh80xtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dmbH54prDzJ4681;
	Thu,  8 Jan 2026 01:53:05 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B2A940539;
	Thu,  8 Jan 2026 01:53:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 7 Jan
 2026 17:53:08 +0000
Date: Wed, 7 Jan 2026 17:53:06 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] efi/cper: don't dump the entire memory region
Message-ID: <20260107175306.00005d5c@huawei.com>
In-Reply-To: <f47447094cfa388042ed3563acaeb06c98ee5248.1767804050.git.mchehab+huawei@kernel.org>
References: <cover.1767804050.git.mchehab+huawei@kernel.org>
	<f47447094cfa388042ed3563acaeb06c98ee5248.1767804050.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 17:41:52 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current logic at cper_print_fw_err() doesn't check if the
> error record length is big enough to handle offset. On a bad firmware,
> if the ofset is above the actual record, length -= offset will
> underflow, making it dump the entire memory.
> 
> The end result can be:
> 
> - the logic taking a lot of time dumping large regions of memory;
> - data disclosure due to the memory dumps;
> - an OOPS, if it tries to dump an unmapped memory region.
> 
> Fix it by checking if the section length is too small before doing
> a hex dump.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

