Return-Path: <linux-efi+bounces-2480-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECC9FC038
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 17:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7CC7A06C8
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6AD1FF5F7;
	Tue, 24 Dec 2024 16:25:18 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4C19DF98;
	Tue, 24 Dec 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735057518; cv=none; b=f/c2iTxQVZ52A3Z1IKqttN66Q2LDBCm/3HhjAjqA85NKFdcaE09Y++a8WxHZYxtPkW441MgllVHnXVVu/5ivJGk4UbzRUOJy+ENPk6ngVTxWgOL9f+T46U7rvI7xog61WkroP3HZdlFqeKrDSL1zh4dNDGjmxSCr7IQIirtuRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735057518; c=relaxed/simple;
	bh=EER92mhgPxeEhMa/wz/BTFFXGboocmFty6bViE++Ir8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INK/mrNAGNBvbke42kV/3S/kGlJ530xYSSNnomUj4DpvR0mxjrhFelIWxv53JqDIcfaM5AoRzBTdFoiVH6SBLq8TninM46AoUWxtuJwzDYx47e+JYl0bewXy1cS1gMMyjPpMztPV3NyoqEzXfBvREiO5YgEjBDnP/WlAl5JEU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHgB90fXKz6K9KJ;
	Wed, 25 Dec 2024 00:21:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F5D6140133;
	Wed, 25 Dec 2024 00:25:14 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 17:25:12 +0100
Date: Tue, 24 Dec 2024 16:25:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zijun Hu <zijun_hu@icloud.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Thomas =?ISO-8859-1?Q?Wei=DFschu?=
 =?ISO-8859-1?Q?h?= <thomas@t-8ch.de>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-sound@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux1394-devel@lists.sourceforge.net>,
	<arm-scmi@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-hwmon@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-remoteproc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: Re: [PATCH v5 10/12] cxl/pmem: Replace match_nvdimm_bridge() with
 API device_match_type()
Message-ID: <20241224162510.000009b5@huawei.com>
In-Reply-To: <20241224-const_dfc_done-v5-10-6623037414d4@quicinc.com>
References: <20241224-const_dfc_done-v5-0-6623037414d4@quicinc.com>
	<20241224-const_dfc_done-v5-10-6623037414d4@quicinc.com>
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

On Tue, 24 Dec 2024 21:05:09 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Static match_nvdimm_bridge(), as matching function of device_find_child()
> matches a device with device type @cxl_nvdimm_bridge_type, and its task
> can be simplified by the recently introduced API device_match_type().
> 
> Replace match_nvdimm_bridge() usage with device_match_type().
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
With new follow up, I'm fine with this.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

