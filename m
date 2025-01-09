Return-Path: <linux-efi+bounces-2558-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0383EA08281
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 22:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288143A3CE8
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0A2054EC;
	Thu,  9 Jan 2025 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CeNGNqqZ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CeNGNqqZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD92054E2
	for <linux-efi@vger.kernel.org>; Thu,  9 Jan 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459568; cv=none; b=NYiLHdMyrqCadRQJ3Ji/mxhBKya/nw0CzugJza869red4CCCdhHRbhKNJUK7HLNskdgnZBCeOsKY0eYeJb20Jyxt/0g6WoM6P2YzHxJjPWeC/J1kS39PV0xN0DKSqHOKBZtdj3ZRrL3kkbxjqPPxiO5n1Af7HVAQulM66lIkRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459568; c=relaxed/simple;
	bh=VFQLCgVP22L0c2IQ3fERqBYa6nJAwxZpg9y1TDD8zgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRoeqVZqVTRvS7ivlD88NMwSQbihARKVHCTMKPnZxH3GAbzP2Q1LORHPlJnOGrYNwpLP9W2pdm1W7sKKzfOkAx8Tk9qW0Y6NrkxjoJZGVpt3TBqu434Sju5fSqyftg68HjAepoSGnGERyCHLj5p5011mXXKdQh74XXUdeYos+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CeNGNqqZ; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CeNGNqqZ; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736459565;
	bh=VFQLCgVP22L0c2IQ3fERqBYa6nJAwxZpg9y1TDD8zgE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CeNGNqqZYvtrhiKaDG0VDB8nqiKEePANYQIwCHzYZIK7m6JLLEvTYYsZ68YDkb5cN
	 uTFEx3rG0Jh+B6XQLm/+0XTVv0/BafzUlRsR+crqsZGebAmZPNRLHwlXgfb5eZnOdL
	 jwiPloK8tRAB+wXQ2v5NanfWUxJguJw/Bsh7lvmA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 75B191281701;
	Thu, 09 Jan 2025 16:52:45 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 0Yu-AEH0zGbq; Thu,  9 Jan 2025 16:52:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736459565;
	bh=VFQLCgVP22L0c2IQ3fERqBYa6nJAwxZpg9y1TDD8zgE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CeNGNqqZYvtrhiKaDG0VDB8nqiKEePANYQIwCHzYZIK7m6JLLEvTYYsZ68YDkb5cN
	 uTFEx3rG0Jh+B6XQLm/+0XTVv0/BafzUlRsR+crqsZGebAmZPNRLHwlXgfb5eZnOdL
	 jwiPloK8tRAB+wXQ2v5NanfWUxJguJw/Bsh7lvmA=
Received: from [10.106.168.49] (unknown [167.220.100.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0DD6212816F3;
	Thu, 09 Jan 2025 16:52:45 -0500 (EST)
Message-ID: <a712d117c356b7c7843f8bafad26a438be81a1e0.camel@HansenPartnership.com>
Subject: Re: fs/efivarfs/vars.c:375: warning: Function parameter or struct
 member 'duplicate_check' not described in 'efivar_init'
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>
Date: Thu, 09 Jan 2025 13:52:43 -0800
In-Reply-To: <202501100429.RSwlJMm0-lkp@intel.com>
References: <202501100429.RSwlJMm0-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-01-10 at 05:02 +0800, kernel test robot wrote:
> tree:  
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> head:   5e948d5cefebebe2315faf356d7b5180144b17b0
> commit: 43039cdd1a14ed12c7b506a2d78c7fa708444b06 efivarfs: add
> variable resync after hibernation
> date:   11 hours ago
> config: x86_64-buildonly-randconfig-002-20250109
> (https://download.01.org/0day-ci/archive/20250110/202501100429.RSwlJM
> m0-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build):
> (https://download.01.org/0day-ci/archive/20250110/202501100429.RSwlJM
> m0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202501100429.RSwlJMm0-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> > > fs/efivarfs/vars.c:375: warning: Function parameter or struct
> > > member 'duplicate_check' not described in 'efivar_init'

Sorry, my fault.  If you fold this one-liner into "efivarfs: add
variable resync after hibernation" it will correct the warning.

James

---

diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index d720d780648b..6edc10958ecf 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -364,6 +364,7 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
  * efivar_init - build the initial list of EFI variables
  * @func: callback function to invoke for every variable
  * @data: function-specific data to pass to @func
+ * @duplicate_check: fail if a duplicate variable is found
  *
  * Get every EFI variable from the firmware and invoke @func. @func
  * should populate the initial dentry and inode tree.


