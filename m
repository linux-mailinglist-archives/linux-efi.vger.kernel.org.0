Return-Path: <linux-efi+bounces-113-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2348080486F
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 05:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BBA28102C
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 04:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA42CA4C;
	Tue,  5 Dec 2023 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtsmoCvy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77189FA;
	Mon,  4 Dec 2023 20:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701749458; x=1733285458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BgAKyIE8Taig/P+FmUDkLxkyIqxSRk5PyzxoVtR/DZI=;
  b=ZtsmoCvyru3GN26iuUtg+xjjWRjrsUF+260E6CfwvUv0yf+zYxkgyaAW
   jYQGwzrhJd1oP2VV8XAdNAtR0pVxqHeC4T+BROfcK425ZuCZm+vHbq5SP
   OWOVSw86ZSlbG2oQc1iItZ3PcfFCGZPAW3ze6cJv5Hd0vG2/Ic7YD1iVq
   ms6XhnAEEYb5QEYMof4dyQe0iB672BcPySqLGHf6mG2GAKm2Wm0RZEgcE
   d8GY/zaEXF3ODQVny1rspW7DVXmGR9NS7nZ7sJ3iKVL3UxaMV4Lw489bw
   AK11NLOWpzl47fQBjW7ExswnlKDKeONhjHwOhoJYBZzZCbjprAMEgs+SK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="716332"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="716332"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 20:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="747079121"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="747079121"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 20:10:53 -0800
Date: Tue, 5 Dec 2023 06:10:50 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 0/5] Support _UID matching for integer types
Message-ID: <ZW6iyu4qF0V7wCXG@black.fi.intel.com>
References: <20231123100617.28020-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>

On Thu, Nov 23, 2023 at 03:36:12PM +0530, Raag Jadav wrote:
> This series updates the standard ACPI helpers to support _UID matching
> for both integer and string types, and uses them in a couple of places.
> 
> Changes since v2:
> - Drop __builtin functions to reduce complexity (Rafael)
> - Update tags
> 
> Changes since v1:
> - Fix build errors

Bump.

Anything I can do to move this forward?

Raag

