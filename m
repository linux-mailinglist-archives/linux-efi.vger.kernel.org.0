Return-Path: <linux-efi+bounces-408-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C282E22D
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jan 2024 22:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262AF2811C7
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jan 2024 21:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824C199AA;
	Mon, 15 Jan 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rCpi704M"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFE1B26E;
	Mon, 15 Jan 2024 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FOAsIVXR2F1MNrAEXWm5jpmFbdqxyTKKAOVodsOYntg=; b=rCpi704MO+P17OySm+1fm5KceN
	iPhz75xGzN7N1GjQXvNGowzjMDBoYuMBieV1Ua7ZU8o9gGQorDwg6tQcBPGTgenRha6fooEpDe1wE
	gbxrJSHfgQOdb3BOAqO16oTqwioEeCkGVZjz+ObhDAxY6aT8oqLZFZzEXz0rNAX/H4RQjF4LCGpoX
	99z/cEgFigxREFqT8DgjRClOgmxC14PRGMgBodhqk56KC4QOE6mEakF9yiFEt/QCAJKF2neRIiPFr
	/dJA8acQ60HBuamZHkFekSO3cymRFGEbqiVXIzggXboKGcNLSudpiN5CnRelJe5LIbO+Odz0t7XI3
	TIlW/hNQ==;
Received: from [191.193.161.120] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rPUO2-006lRW-OW; Mon, 15 Jan 2024 22:20:51 +0100
Message-ID: <706a5008-331b-34ea-c177-bb0070375099@igalia.com>
Date: Mon, 15 Jan 2024 18:20:45 -0300
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] efi: pstore: Allow dynamic initialization based on module
 parameter
Content-Language: en-US
To: linux-efi@vger.kernel.org
Cc: ardb@kernel.org, keescook@chromium.org, tony.luck@intel.com,
 linux-hardening@vger.kernel.org, kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20240103184053.226203-1-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240103184053.226203-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/01/2024 15:40, Guilherme G. Piccoli wrote:
> The efi-pstore module parameter "pstore_disable" warrants that users
> are able to deactivate such backend. There is also a Kconfig option
> for the default value of this parameter. It was originally added due
> to some bad UEFI FW implementations that could break with many variables
> written.
> 
> Some distros (such as Arch Linux) set this in their config file still
> nowadays. And once it is set, even being a writable module parameter,
> there is effectively no way to make use of efi-pstore anymore.
> If "pstore_disable" is set to true, the init function of the module exits
> early and is never called again after the initcall processing.
> 
> Let's switch this module parameter to have a callback and perform the
> pstore backend registration again each time it's set from Y->N (and
> vice-versa). With this, the writable nature of the parameter starts to
> make sense, given that users now can switch back to using efi-pstore
> or not during runtime by writing into it.

Hi folks, a friendly ping - any comments on this one, suggestions?
Thanks in advance,


Guilherme

