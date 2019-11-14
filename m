Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D771FFC224
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfKNJIG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 04:08:06 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48675 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfKNJIG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:06 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxv2Jjpz9sRs; Thu, 14 Nov 2019 20:08:02 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4238fad366a660cbc6499ca1ea4be42bd4d1ac5b
In-Reply-To: <1572492694-6520-3-git-send-email-zohar@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v10 2/9] powerpc/ima: add support to initialize ima policy rules
Message-Id: <47DFxv2Jjpz9sRs@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:02 +1100 (AEDT)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2019-10-31 at 03:31:27 UTC, Mimi Zohar wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> PowerNV systems use a Linux-based bootloader, which rely on the IMA
> subsystem to enforce different secure boot modes.  Since the verification
> policy may differ based on the secure boot mode of the system, the
> policies must be defined at runtime.
> 
> This patch implements arch-specific support to define IMA policy
> rules based on the runtime secure boot mode of the system.
> 
> This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
> config is enabled.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4238fad366a660cbc6499ca1ea4be42bd4d1ac5b

cheers
