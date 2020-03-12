Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA43B182EC5
	for <lists+linux-efi@lfdr.de>; Thu, 12 Mar 2020 12:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgCLLQA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Mar 2020 07:16:00 -0400
Received: from ozlabs.org ([203.11.71.1]:41585 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgCLLP7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 12 Mar 2020 07:15:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48dR8X5Bv8z9sPF;
        Thu, 12 Mar 2020 22:15:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1584011757;
        bh=4geycpt2qvWbUaRVZsgFbTdpxz2a/tZbMuUtWLTmjn8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Nsh7A3T9QhufussDqh6t2HhZOJeKPshqGQLRydZ+4DqE+DrYrNK8p09zF6lMuNbPp
         lqkyUlaVR+EWRRHqzjzcy/Df2pSVAHJJvp0A5SlXuPfvbSNYH34AQONTelobFpo72G
         7oz//YPk0Ej2OZc7yxOHsdnwE3hMi42WqftrRjwvwnKodujlENXI1qwe2svalECXMO
         muqFxOsAtIuAnGakEDji8IzpRNo7xRVqmdTBStq9I/w3//nIYtD95x3qjjBoKNydll
         prwdvFroRQMPje7gm8XTWT2INbodh9tjCxtJCNxb6TFYHU2Ku9N9/8wMdU5+Pett6E
         uE1RDylgnsSpw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>, zohar@linux.ibm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v3] ima: add a new CONFIG for loading arch-specific policies
In-Reply-To: <1583715471-15525-1-git-send-email-nayna@linux.ibm.com>
References: <1583715471-15525-1-git-send-email-nayna@linux.ibm.com>
Date:   Thu, 12 Mar 2020 22:15:54 +1100
Message-ID: <87d09hj02d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Nayna Jain <nayna@linux.ibm.com> writes:
> From: Nayna Jain <nayna@linux.vnet.ibm.com>
>
> Every time a new architecture defines the IMA architecture specific
> functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
> include file needs to be updated. To avoid this "noise", this patch
> defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
> the different architectures to select it.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v3:
> * Removes CONFIG_IMA dependency. Thanks Ard.
> * Updated the patch with improvements suggested by Michael. It now uses
> "imply" instead of "select". Thanks Michael.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
