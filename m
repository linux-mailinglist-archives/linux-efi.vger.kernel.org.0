Return-Path: <linux-efi+bounces-413-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC082EDB8
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0637E1F24691
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562761B810;
	Tue, 16 Jan 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="o7bTQ87U"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1DD1B7F3;
	Tue, 16 Jan 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qW2SLTYmhhiEpyEF3zt0xs04Xw8Tf6bFMpsEHK/fRWo=; b=o7bTQ87UYmVpXeJ+/XLhVHDGgq
	B3VSqrZ+cquF6TclHRT8AfUExGAwVJKKtECCkUI4MmNJIZUF4eKgcJ45nUQiAvoIe7PnVI4zj3OFg
	b7XEr+16+M7O2B1ZfXyzj+RtJIVwnY5gK6NM2nNMq/0KNYNYCnlj8lDS64mrI4Z8v6Ecu7RfzYGDS
	d2sVH9Sc9BI675vJyapv8oRpHFeGHe1l5JAFKZH7n4aJk3fcMfVq1VfukjJIGrL+2cFJoQJ+oz51M
	0Mw7lbHP3FaZuwFTCRwZ2lL/hmeoNaYBQBhA2pYZB+QacfTGwQxswaCVGBwHyr9LDs5NKWvHqSPGz
	X3DiUsLA==;
Received: from [191.193.161.120] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rPhdR-006wRD-DJ; Tue, 16 Jan 2024 12:29:37 +0100
Message-ID: <56ed2c3c-5bc5-0f52-92cf-b1f885d8fa4e@igalia.com>
Date: Tue, 16 Jan 2024 08:29:32 -0300
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-efi@vger.kernel.org, ardb@kernel.org, keescook@chromium.org,
 tony.luck@intel.com, linux-hardening@vger.kernel.org, kernel@gpiccoli.net,
 kernel-dev@igalia.com
References: <20240103184053.226203-1-gpiccoli@igalia.com>
 <706a5008-331b-34ea-c177-bb0070375099@igalia.com>
 <2024011654-setup-pointer-59d4@gregkh>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <2024011654-setup-pointer-59d4@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 05:46, Greg KH wrote:
> On Mon, Jan 15, 2024 at 06:20:45PM -0300, Guilherme G. Piccoli wrote:
>> On 03/01/2024 15:40, Guilherme G. Piccoli wrote:
>>> The efi-pstore module parameter "pstore_disable" warrants that users
>>> are able to deactivate such backend. There is also a Kconfig option
>>> for the default value of this parameter. It was originally added due
>>> to some bad UEFI FW implementations that could break with many variables
>>> written.
>>>
>>> Some distros (such as Arch Linux) set this in their config file still
>>> nowadays. And once it is set, even being a writable module parameter,
>>> there is effectively no way to make use of efi-pstore anymore.
>>> If "pstore_disable" is set to true, the init function of the module exits
>>> early and is never called again after the initcall processing.
>>>
>>> Let's switch this module parameter to have a callback and perform the
>>> pstore backend registration again each time it's set from Y->N (and
>>> vice-versa). With this, the writable nature of the parameter starts to
>>> make sense, given that users now can switch back to using efi-pstore
>>> or not during runtime by writing into it.
>>
>> Hi folks, a friendly ping - any comments on this one, suggestions?
> 
> It's the middle of the merge window, not much anyone can do until after
> that is over to pick up new stuff.
> 
> thanks,
> 
> greg k-h
> 

OK, that's fine! No hurries, and thanks for your response Greg :)

