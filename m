Return-Path: <linux-efi+bounces-6101-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MuLK/meiWlU/wQAu9opvQ
	(envelope-from <linux-efi+bounces-6101-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Feb 2026 09:46:49 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC8510D296
	for <lists+linux-efi@lfdr.de>; Mon, 09 Feb 2026 09:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B77C93003D25
	for <lists+linux-efi@lfdr.de>; Mon,  9 Feb 2026 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8A325720;
	Mon,  9 Feb 2026 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI3rW6UQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A226318B89;
	Mon,  9 Feb 2026 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626808; cv=none; b=osYTrLIBhFAQ17GOTOEszCM++XAMVKzikMmPpRmLsWavIqsPoXczw2Dj6z3jWBPYDWJ0Zcu3OxzXzRCbCrpS8978MKAH6xPb7S5SPqhWuYFeRoUOcct/xKZ5PRRWClR2Ol+XOH8uqeVH/rEMLSvS9j0di2QBrTVhNYaC9BZIheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626808; c=relaxed/simple;
	bh=VqGTlBXTKn8BL1/CCfeqrnRQpUd3nyZSaUduelsWnXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piiHwEHPvKVAp9WaVr63bzZQzLb95Szffmy17HanC1eBzYd4O88ThQ4Fgn5Q12QPLtomdZvUJTQ2Qu2oJoAedG2kVRhGjF38LaaxGXG8rK1PL/ArhdrkohOWujZoBtPfbq/7+d6/xxBszgBVhT+8yeMXeqlbZ91fUQPg3xDOAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI3rW6UQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BE8C116C6;
	Mon,  9 Feb 2026 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770626807;
	bh=VqGTlBXTKn8BL1/CCfeqrnRQpUd3nyZSaUduelsWnXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rI3rW6UQvOnQT9WOajUkBRyibhi1VXSxZNvGsn9oLDm2xqfF1dw2fsY4eHsFkgfat
	 FwcGafBTVUz1NcPST3ciM6qhlvKsSpWr8Lsll+ZD9XTPvSanpdh6l5QPh6UbL2zzkE
	 bO5cSClCJaBv4kMg9IrM8gmFdiCR9rhUAdN0AD4wnCmMhhvBc4OALi/wouoEAC2u3J
	 EvAqsQeTjgt7YuTs1dPPhmyTbsk8YI4bOGz2Ehy8VcNrQW9jB5XBSs2IuP+1i1YE3h
	 f6wr0l3vpX4+P3nBNZYrR8MrWu1jtxbNffrs20alCI294HkZUqn0sDTJZHEto9tOul
	 1Kvwjl+UxI3wQ==
Message-ID: <f4409418-bd9e-471e-8a97-5c99481cba51@kernel.org>
Date: Mon, 9 Feb 2026 09:46:44 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi: Save Brightness using EFI on Macs
To: Lukas Wunner <lukas@wunner.de>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20260206125641.12983-1-atharvatiwarilinuxdev@gmail.com>
 <20260206125641.12983-2-atharvatiwarilinuxdev@gmail.com>
 <c2d14818-1c34-47c7-a210-1f7c737f0bc9@kernel.org>
 <aYiMqKJgtaah8pLW@wunner.de>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <aYiMqKJgtaah8pLW@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6101-lists,linux-efi=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,linux-efi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BC8510D296
X-Rspamd-Action: no action

Hi,

On 8-Feb-26 14:16, Lukas Wunner wrote:
> On Sun, Feb 08, 2026 at 11:45:55AM +0100, Hans de Goede wrote:
>> I was already worried about the shutdown approach on v1,
>> but did not say anything since I'm not that familiar
>> with apple hw and other apple code is already doing
>> something similar.
> 
> Yes, macOS saves the brightness so that it's persisted across reboots
> and can be set already by the EFI firmware, avoiding a bloom effect
> (brightness change) on handover to the OS.  We want to provide the
> same seamless user experience on Linux that users have grown accustomed
> to on macOS, I think that's a reasonable thing to do.
> 
>> But writing a non-volatile EFI variable every 300ms is
>> just a very very bad idea.
> 
> Agreed.  But what do you think about a delayed write when brightness
> is changed, so that brightness is persisted even if the OS crashes?
> Users don't change brightness that often, I can't imagine that it
> amounts to a significantly higher number of writes than if it's
> only done on shutdown.

How about saving the bootup brightness and then on shutdown
compare and store it only if it changed ?

That seems the safest approach. OS crashes should be seldom and
the brightness not getting restored will be the least of a user's
worries if those happen.

Something like this should really be written to minimize
the amount of nvram writes.

It might actually be a good idea to change the existing apply
brightness saving code in the same way.

Regards,

Hans




