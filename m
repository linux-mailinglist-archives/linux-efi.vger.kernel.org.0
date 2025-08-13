Return-Path: <linux-efi+bounces-4543-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB616B243B7
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 10:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B81893DA0
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E84B2D3A93;
	Wed, 13 Aug 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyFoTYNc"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC61DE8BF
	for <linux-efi@vger.kernel.org>; Wed, 13 Aug 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072237; cv=none; b=rRZ+BKl1pBrXdjn9c4+YdFikw03LUuxD7pVcF5IMPD0sXxo7faLo9CPsCkwwaWb8N0RMR9rdhTRrPbKUHbYyByWT4lnEPwDECmG//XXlCVUJF4HQyPHCPfw7OxYRc4ONq+gPZG7yPa8vcuH+kXU90w6l3Rs/Z5DgV3H7pD35b88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072237; c=relaxed/simple;
	bh=fi758/DWS4ZOaQ7xm2eAo24kUA2npGMXzbhYLcHl/lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKleIPZ27Wnt1iDKSlgLMgisksqu1pFz+YnnthcncP+nV10abZywAJ3n+usa9Yab2TOWqMd18fOeuuQiT4lGQrwO1oEHd/aP53p2wFWh/3GvDmbvFv3lkBp3XWFHm+qtG9GwDiLqCLMOStiGBsP5ZepD1v1HQgTqFqRE+mjT63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyFoTYNc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755072234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpnKLvmz+Be0L+0z6ZXlHIf2RbAC8orLhd1bOKh736E=;
	b=SyFoTYNcEPOwBtTrjAYEO/kJGvNk/ypvXWgc2wPX0m9gkehb9b6/uOC3aQOr21okAb8Wip
	WpXVEDpxTd9T0NxoQK+DMBiTJ3QQh/xuaMD5xpmKXfo2TgAKTeAWucnYKXqDlX7ug6J6sg
	2gxsADQoQiwCvbH7fzKIIhi4DZ8AVWw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-THgix_QbMFyPLcxU5AlqFg-1; Wed,
 13 Aug 2025 04:03:50 -0400
X-MC-Unique: THgix_QbMFyPLcxU5AlqFg-1
X-Mimecast-MFC-AGG-ID: THgix_QbMFyPLcxU5AlqFg_1755072229
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 963F018003FD;
	Wed, 13 Aug 2025 08:03:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.64])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B53518002A0;
	Wed, 13 Aug 2025 08:03:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C011C18000B2; Wed, 13 Aug 2025 10:03:46 +0200 (CEST)
Date: Wed, 13 Aug 2025 10:03:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: Explain OVMF acronym in OVMF_DEBUG_LOG help text
Message-ID: <udidf2skqwbhx6mg4tmsxuipqqgh4amwcxvbjdrqs5g5vla6xp@7wiyrojpjok4>
References: <ed9efeafd80e9827bcc028d20a5bb20653af68e7.1755006858.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9efeafd80e9827bcc028d20a5bb20653af68e7.1755006858.git.geert+renesas@glider.be>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Aug 12, 2025 at 03:54:29PM +0200, Geert Uytterhoeven wrote:
> People not very intimate with EFI may not know the meaning of the OVMF
> acronym.  Write it in full, to help users with making good decisions
> when configuring their kernels.
> 
> Fixes: f393a761763c5427 ("efi: add ovmf debug log driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> +	  Recent versions of the Open Virtual Machine Firmware
> +	  (edk2-stable202508 + newer) can write their debug log to a memory
> +	  buffer.  This driver exposes the log content via sysfs
> +	  (/sys/firmware/efi/ovmf_debug_log).

Acked-by: Gerd Hoffmann <kraxel@redhat.com>


