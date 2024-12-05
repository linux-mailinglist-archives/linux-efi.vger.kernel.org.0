Return-Path: <linux-efi+bounces-2294-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93CE9E60B4
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 23:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8D01664A7
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 22:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57E61CEAA3;
	Thu,  5 Dec 2024 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOXeMM8O"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1001B87F5;
	Thu,  5 Dec 2024 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733438398; cv=none; b=QiWZCXGOF6zhOirEpOAJvo1uWbKfyjWi3L41pEb8YyKH6jHud5Q8zu+zweCETQBlB7MBpOR5j9V/3eAwUv304FBINN0EYiNpfdPsgv43SIrTCZNR0moIvXvcqrXrFkMiOtvocFvsdhoYtvY9bEwVA6WVPo9eLolPGg0EgSsypXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733438398; c=relaxed/simple;
	bh=bDWc4rhMgoZqDeL0AXlS3HEyZRI+NGFW7RdxbN26PwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FI1Au6DA+JiXtn/+GLlbm46cPPNWiyPJuNTQIl1UVqIqePrLVrkFXe5GaJRaRuO6AKOa1me2KwI1qSI+RVSSUzMMstBn3Xx7HhZSxXRURzRRYGl8reDWI1wDN1UIr8bIC7VP7lj2Bh/5ExjCk2ixdigjpNOOEbtU70R/FzjqP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOXeMM8O; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733438397; x=1764974397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bDWc4rhMgoZqDeL0AXlS3HEyZRI+NGFW7RdxbN26PwE=;
  b=MOXeMM8OltAVUE1ZXy0v3rC4jd3oqpFeBYbp7p7K14hLFccePMA/M7Bq
   bOrDGrK1awvIhAiBS48bHw9nDYPKoEIUYzpildvMOupUBrmKWbIHnFRCa
   fWSZOGztOHlapz+KacZmMr1DaSoSFs2Je2HsUioQEUqvg//nY1BitDiqE
   f9tj3jpf5alLYDOZZrwwz/23RJ/YfHMFs8ifT0x33lX1obzKCAjs3k5SK
   dFvRDbpCjg1BppWTN9ESc9s4e6PWMYSd6H50h0ZvKlfSfIDRwRSn343no
   KFxLDdI/BlPznvfGZJLwQj5jWIhuyqtpW+ov6qpWqpP+y7BmkY4l5oq6W
   Q==;
X-CSE-ConnectionGUID: 4meO4e5XR/uWcMU3EH4Y/w==
X-CSE-MsgGUID: Y9ev3aQHRr60u6LoUFzwig==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33660982"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33660982"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:39:55 -0800
X-CSE-ConnectionGUID: s9cK9Ag1RGqhkbjPJGPt5g==
X-CSE-MsgGUID: +9UlsE4TSWCPuUIT6GPzKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99052989"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.192])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:39:53 -0800
Date: Thu, 5 Dec 2024 14:39:51 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-sound@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3 04/11] driver core: Constify API device_find_child()
 then adapt for various usages
Message-ID: <Z1IrtwPo4Pj52fuY@aschofie-mobl2.lan>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-4-1611f1486b5a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-const_dfc_done-v3-4-1611f1486b5a@quicinc.com>

On Thu, Dec 05, 2024 at 08:10:13AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Constify the following API:
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> To :
> struct device *device_find_child(struct device *dev, const void *data,
>                                  device_match_t match);
> typedef int (*device_match_t)(struct device *dev, const void *data);
> with the following reasons:
> 
> - Protect caller's match data @*data which is for comparison and lookup
>   and the API does not actually need to modify @*data.
> 
> - Make the API's parameters (@match)() and @data have the same type as
>   all of other device finding APIs (bus|class|driver)_find_device().
> 
> - All kinds of existing device match functions can be directly taken
>   as the API's argument, they were exported by driver core.
> 
> Constify the API and adapt for various existing usages by simply making
> various match functions take 'const void *' as type of match data @data.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  arch/sparc/kernel/vio.c                |  6 +++---
>  drivers/base/core.c                    |  6 +++---
>  drivers/block/sunvdc.c                 |  6 +++---
>  drivers/bus/fsl-mc/dprc-driver.c       |  4 ++--
>  drivers/cxl/core/pci.c                 |  4 ++--
>  drivers/cxl/core/pmem.c                |  2 +-
>  drivers/cxl/core/region.c              | 21 ++++++++++++---------
>  drivers/firewire/core-device.c         |  4 ++--
>  drivers/firmware/arm_scmi/bus.c        |  4 ++--
>  drivers/firmware/efi/dev-path-parser.c |  4 ++--
>  drivers/gpio/gpio-sim.c                |  2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 +-
>  drivers/hwmon/hwmon.c                  |  2 +-
>  drivers/media/pci/mgb4/mgb4_core.c     |  4 ++--
>  drivers/nvdimm/bus.c                   |  2 +-
>  drivers/pwm/core.c                     |  2 +-
>  drivers/rpmsg/rpmsg_core.c             |  4 ++--
>  drivers/scsi/qla4xxx/ql4_os.c          |  3 ++-
>  drivers/scsi/scsi_transport_iscsi.c    | 10 +++++-----
>  drivers/slimbus/core.c                 |  8 ++++----
>  drivers/thunderbolt/retimer.c          |  2 +-
>  drivers/thunderbolt/xdomain.c          |  2 +-
>  drivers/tty/serial/serial_core.c       |  4 ++--
>  drivers/usb/typec/class.c              |  8 ++++----
>  include/linux/device.h                 |  4 ++--
>  include/scsi/scsi_transport_iscsi.h    |  4 ++--
>  net/dsa/dsa.c                          |  2 +-
>  tools/testing/cxl/test/cxl.c           |  2 +-
>  28 files changed, 66 insertions(+), 62 deletions(-)
>

For these cxl and nvdimm pieces:

  drivers/cxl/core/pci.c                 |  4 ++--
  drivers/cxl/core/pmem.c                |  2 +-
  drivers/cxl/core/region.c              | 21 ++++++++++++---------
  drivers/nvdimm/bus.c                   |  2 +-
  tools/testing/cxl/test/cxl.c           |  2 +-

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


snip to end


