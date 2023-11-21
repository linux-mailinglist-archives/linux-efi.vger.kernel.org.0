Return-Path: <linux-efi+bounces-73-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630BE7F343D
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 17:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DA81C21BCD
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2684A9BC;
	Tue, 21 Nov 2023 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhlnC+A2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110F6113;
	Tue, 21 Nov 2023 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700585547; x=1732121547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=41VcV/B0w8wkuOgL+XuhISw4ipqehSYvx8qXQr3tmgQ=;
  b=mhlnC+A2H26xcfPcRG/rhMcbKXs/Xy5FgXZojSVt6dIbhGWpdNd/J9Eb
   Q/qdUaiFLpFaBv27tSG82hv69rPz+uCi7PYAisz+lBFJUIjmZ3gU85UxJ
   d6Pn1EX72a0ZK+NDVZi/+dg0dWt4ssiE0unfdgIftzyB9t5YrpRr1ozvO
   jEZlEFQRoyXHuHTun3IevsfMmWtyerODJ1UmJUssdaMkCiTpJMI1s5gm9
   MO/DBwSGbHLtD8OCNsbiskETkuH5LxEh5BuiNn+9nJftvm2mkaupW3pJz
   EvmdW6b0+HLLFVZiqELQSZsWEHmCZ99qXtuEAi1sJcpunsZxpu02w+3uV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="376913262"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="376913262"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="766700066"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="766700066"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2023 08:52:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 2695313A; Tue, 21 Nov 2023 18:52:18 +0200 (EET)
Date: Tue, 21 Nov 2023 18:52:18 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: andriy.shevchenko@linux.intel.com, rafael@kernel.org, lenb@kernel.org,
	robert.moore@intel.com, ardb@kernel.org, will@kernel.org,
	mark.rutland@arm.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 3/6] ACPI: bus: update acpi_dev_hid_uid_match() to
 support multiple types
Message-ID: <20231121165218.GR1074920@black.fi.intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
 <20231121103829.10027-4-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121103829.10027-4-raag.jadav@intel.com>

On Tue, Nov 21, 2023 at 04:08:26PM +0530, Raag Jadav wrote:
> Now that we have _UID matching support for both integer and string types,
> we can support them into acpi_dev_hid_uid_match() helper as well.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

