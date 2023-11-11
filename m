Return-Path: <linux-efi+bounces-41-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389A7E8BF2
	for <lists+linux-efi@lfdr.de>; Sat, 11 Nov 2023 18:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE2F1C20503
	for <lists+linux-efi@lfdr.de>; Sat, 11 Nov 2023 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2F1BDE4;
	Sat, 11 Nov 2023 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0LfvHww"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344B1BDC6;
	Sat, 11 Nov 2023 17:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23891C433C7;
	Sat, 11 Nov 2023 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699724677;
	bh=6Edi0vC9LiOgbsxo7Eus18euFKTCuNPbb5omqvA3nIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0LfvHwwqV91pqUaZR5D96C/DUoNEis+eOARQ0Xgo0xy5aZNDZZuJdWIZDcwbiP6B
	 qeqhm3w+sQPudByElpCEYTv86EmHFa3eq+DBgp3Vq6bqCdpu7fnUs08NRmmzlAjJtT
	 DwJybcieV1EKhXwAJzKJFXa7LxNNHot5wL/Qy7hJW/ng8MzDfhFgCh5/z6OH24aSo1
	 UYqU4tgm2Iemih3nAIIU+YfX7fH/42plr0qBg7+v9BzDY1nayemfduvJ9W8YU2T03n
	 dBagxMEFrwONmbcLz9LreJwMDub/X5lYyZ3tG2ecHa/8tHxRI9K+d9DgX2QS4yEK0j
	 tV4v1mfzeeHqg==
Date: Sat, 11 Nov 2023 09:44:35 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v7 06/13] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20231111174435.GA998@sol.localdomain>
References: <20231110222751.219836-1-ross.philipson@oracle.com>
 <20231110222751.219836-7-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110222751.219836-7-ross.philipson@oracle.com>

On Fri, Nov 10, 2023 at 05:27:44PM -0500, Ross Philipson wrote:
>  arch/x86/boot/compressed/early_sha1.c   | 12 ++++
>  lib/crypto/sha1.c                       | 81 +++++++++++++++++++++++++

It's surprising to still see this new use of SHA-1 after so many people objected
to it in the v6 patchset.  It's also frustrating that the SHA-1 support is still
being obfuscated by being combined in one patch with SHA-2 support, perhaps in
an attempt to conflate the two algorithms and avoid having to give a rationale
for the inclusion of SHA-1.  Finally, new functions should not be added to
lib/crypto/sha1.c unless those functions have multiple users.

- Eric

