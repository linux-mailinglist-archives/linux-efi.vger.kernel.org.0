Return-Path: <linux-efi+bounces-4230-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2BEAFE300
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1BF3ABA43
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B971C277009;
	Wed,  9 Jul 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZj1oMz6"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB22797B5
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050638; cv=none; b=o9s/m4osadzVnulerjw042bwZWfZnVXk/G/BT/6KG3R1v3EjdpZXEfDB9Tv8rhWPjlMsiWpDgnzjJF09DTdhXQ6wY5P8DzlS2KjOpzIN/Lc9JS2w3TlXCrFE9OtEsdrSYAPH88SKSegitjqAv77jJtDiN+lK+5rBz3cyDL+bzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050638; c=relaxed/simple;
	bh=OvOn5AxMbkFP94/izXI2nF5nheDbptaXTjzBkUKqW7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE9+ON8s4dFt8yOSSC2nP/vj2J7s6Hv2NuFBJw12qwuQX9LmROEyPuhXt7YD1VxZUD1ZxkGyBQDdx2603eVTdbAdts4RDVLuG2X7dvBFJk8QCKRNW45Vf82W7XC7C50t3zQzmbFVH3grcYrfdQUQssljZrQXYOqJr2T3otNyhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZj1oMz6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752050632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PpUb3mk52hXPRi0KWwH7xKKlrHQcC+R2WTlncPo7rfQ=;
	b=VZj1oMz6ikTLxXrSo+USztLXj52SwftIxv96Qwp+nZsBqQEly4GtfeHJpRM/UyM1CFpW/C
	khX8A/VrWp+ym9QjfWwhVK6Ilab+3VL8AAUq2GSyaaVBhMjKY6rMUockL0+RLEn9YDojwY
	4EP6sYEQdQhLquIKZP/6vaxNPxTk4Nc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-3pW2NTN0OfiC2rqy7eZ_tw-1; Wed,
 09 Jul 2025 04:43:47 -0400
X-MC-Unique: 3pW2NTN0OfiC2rqy7eZ_tw-1
X-Mimecast-MFC-AGG-ID: 3pW2NTN0OfiC2rqy7eZ_tw_1752050626
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAD7B19560A6;
	Wed,  9 Jul 2025 08:43:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DA3F180035C;
	Wed,  9 Jul 2025 08:43:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 0149A18000B2; Wed, 09 Jul 2025 10:43:42 +0200 (CEST)
Date: Wed, 9 Jul 2025 10:43:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [efi:next 1/1] ERROR: modpost: "efi_kobj"
 [drivers/firmware/efi/ovmf-debug-log.ko] undefined!
Message-ID: <5ykr26mowvsliuuyj5gvlw4wl5pginnk2y6zj3nm2f3roxhqxk@l7yelfo2nbm6>
References: <202507091432.rbbrjGoU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507091432.rbbrjGoU-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jul 09, 2025 at 02:10:09PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> head:   42c68c6e354f71498f9e3e31aa5b0f9243bc1618
> commit: 42c68c6e354f71498f9e3e31aa5b0f9243bc1618 [1/1] efi: add ovmf debug log driver
> config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20250709/202507091432.rbbrjGoU-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250709/202507091432.rbbrjGoU-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507091432.rbbrjGoU-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "efi_kobj" [drivers/firmware/efi/ovmf-debug-log.ko] undefined!

I think this is because ovmf-debug-log is the first /modular/ user of
efi_kobj.  So the options are to (a) export the symbol, or (b) switch
the driver from tristate to bool.

Ard, any preference?

take care,
  Gerd


