Return-Path: <linux-efi+bounces-72-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C2B7F3438
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 17:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138961C21AE9
	for <lists+linux-efi@lfdr.de>; Tue, 21 Nov 2023 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F6F4A9AF;
	Tue, 21 Nov 2023 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PespO3HB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8D193;
	Tue, 21 Nov 2023 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700585452; x=1732121452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTdRqF+yP9i6uEWuxlLEu23get1OZ+Y4sxPkDDh2+QM=;
  b=PespO3HB7JL+wDyKX122PAkIxmlafqGNF4L4j6G6RIAP1ZtEMPvYAGoD
   0C3Q/IsUXbzqB81RALyF/jPYnzOPjNsUO12kXukKAuWdJ7tqWjcfz7oUO
   oaFgdRgLijcfjDzJh6glF+1CImk6KO+wVQbYESrV8sVsGkp+9g76DKum4
   ytVHVvw31joVPIRCJS04rZxa860IoYQ7jATXkHYYNazhtl77UcsqkUuPP
   I3Tw225ECkeeFwsf3dYAhtmnPUGCQajHZHI6XH0MjC0XGK8rFsYCEl36z
   D8mzRiSSZDRx3b3cYJ5um3ky50lJWHyKmPQbURcCbme8CoZuSiexrVhsz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13422930"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="13422930"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795842221"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="795842221"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2023 08:50:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A498513A; Tue, 21 Nov 2023 18:50:45 +0200 (EET)
Date: Tue, 21 Nov 2023 18:50:45 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: andriy.shevchenko@linux.intel.com, rafael@kernel.org, lenb@kernel.org,
	robert.moore@intel.com, ardb@kernel.org, will@kernel.org,
	mark.rutland@arm.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support
 multiple types
Message-ID: <20231121165045.GQ1074920@black.fi.intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
 <20231121103829.10027-3-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121103829.10027-3-raag.jadav@intel.com>

On Tue, Nov 21, 2023 at 04:08:25PM +0530, Raag Jadav wrote:
> According to ACPI specification, a _UID object can evaluate to either
> a numeric value or a string. Update acpi_dev_uid_match() helper to
> support _UID matching for both integer and string types.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

