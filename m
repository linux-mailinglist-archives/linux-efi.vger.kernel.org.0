Return-Path: <linux-efi+bounces-4251-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7167AFEC0F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BD21BC0EA0
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E42F2E5B36;
	Wed,  9 Jul 2025 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXXQtT1s"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC02E5B1F
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071525; cv=none; b=p2xFOVlpweEGf2HH1t+K59heHoQwgF76xuNWoYaAlInWbcpuMD7wIxrkyOOdshVioJQCzeJMnTYKDDJNimNFCcNppvnzJSPHzQD8wsjntIfHO3pNMVo+PgK/virA7l8JrIxgYzbZB1ZkP5wsQ9/c+VIYuQA6F4ApN82+oQC7rBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071525; c=relaxed/simple;
	bh=JQFCOM0gh2eJ78Qz2VCNyFntdnwTzz+cRk1BMrePsOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3qUDdFLli4OnyWTSbDHkpgbCQztS0WAOACiO7cLj5g2Rx4mVrKTWELwSYv9JYj9WPsgMmANXabUFOxflsNw15Zek8/mfUMlG9mPLAAnnMEWPiLj1V0E17hpgkZklbtT4BvQjTZFW8Xcxa+WfGk+N5eQl3yWCLIz6H8/WNIZDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXXQtT1s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752071523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NrwyNCr3bkuUWptfYFMDgj7WANqDCa1hc7XB3EIA9aU=;
	b=AXXQtT1sRAOdhD/zdyRFRLznh9yvaQOCYXzux6Fe9/CogM0NeTis1g5QMvoVV1ONJq3g4K
	Pe1H79ZgM0IrxmwYaA0+3gr1YkXh3wQysKxvZmWYYjrrjCe9P+qTYtJcJyi9sXQnb4Ua8D
	y501jiuGx8UWXc+9jvLaYIVNttiI0b4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-2TkPCWOePuyHdjrTfn3O6g-1; Wed,
 09 Jul 2025 10:32:01 -0400
X-MC-Unique: 2TkPCWOePuyHdjrTfn3O6g-1
X-Mimecast-MFC-AGG-ID: 2TkPCWOePuyHdjrTfn3O6g_1752071520
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A868E1954237;
	Wed,  9 Jul 2025 14:32:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.100])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45B1319560A0;
	Wed,  9 Jul 2025 14:32:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id E719618000B2; Wed, 09 Jul 2025 16:31:57 +0200 (CEST)
Date: Wed, 9 Jul 2025 16:31:57 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] efi: add ovmf debug log driver
Message-ID: <4cix3k4h32wozt3nxic5un7jyzfjrmqmzbzmtr3ivw5b2bz363@mw6bke7w4oaq>
References: <20250708125624.734132-1-kraxel@redhat.com>
 <6edfa099-ab0c-41f6-89ea-0fd67666dd05@kernel.org>
 <2mn65slwkwmjpeilma2isw7zgabdmda4rhpqjiutwdwqno2wrh@zghymlce2fiy>
 <8621135e-445a-42dd-89e0-bf8fc3e2b6b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8621135e-445a-42dd-89e0-bf8fc3e2b6b7@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jul 09, 2025 at 04:20:49PM +0200, Krzysztof Kozlowski wrote:
> On 09/07/2025 16:17, Gerd Hoffmann wrote:
> > On Wed, Jul 09, 2025 at 03:58:58PM +0200, Krzysztof Kozlowski wrote:
> >> On 08/07/2025 14:56, Gerd Hoffmann wrote:
> >>> +MODULE_DESCRIPTION("OVMF debug log");
> >>> +MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> >>> +MODULE_LICENSE("GPL");
> >>> +MODULE_ALIAS("platform:ovmf_debug_log");
> >>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> >>> index db8c5c03d3a2..ac0a03ec3452 100644
> >>> --- a/drivers/firmware/efi/Kconfig
> >>> +++ b/drivers/firmware/efi/Kconfig
> >>> @@ -263,6 +263,14 @@ config EFI_COCO_SECRET
> >>>  	  virt/coco/efi_secret module to access the secrets, which in turn
> >>>  	  allows userspace programs to access the injected secrets.
> >>>  
> >>> +config OVMF_DEBUG_LOG
> >>> +	tristate "Expose OVMF firmware debug log via sysfs"
> >>> +	depends on EFI
> >>> +	help
> >>> +	  Recent OVMF versions (edk2-stable202508 + newer) can write
> >>> +	  their debug log to a memory buffer.  This driver exposes the
> >>> +	  log content via sysfs (/sys/firmware/efi/ovmf_debug_log).
> >>
> >> Where did you document new ABI?
> > 
> > The log buffer header struct is documented in the header file for the
> > edk2 code:
> > https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Library/MemDebugLogLib.h
> 
> You added a new sysfs interface. I meant documentation for this.

The sysfs file contains the log and you can simply use
'cat /sys/firmware/efi/ovmf_debug_log' to read it.

In case the firmware does not have a log buffer the
sysfs file is not present.

take care,
  Gerd


