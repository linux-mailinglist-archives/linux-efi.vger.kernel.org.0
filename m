Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09B2FC24F
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 10:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfKNJJT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 04:09:19 -0500
Received: from ozlabs.org ([203.11.71.1]:34685 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfKNJIM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:12 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFy20h2jz9sPF; Thu, 14 Nov 2019 20:08:07 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2434f7d2d488c3301ae81f1031e1c66c6f076fb7
In-Reply-To: <1572492694-6520-7-git-send-email-zohar@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v10 6/9] certs: add wrapper function to check blacklisted binary hash
Message-Id: <47DFy20h2jz9sPF@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:07 +1100 (AEDT)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2019-10-31 at 03:31:31 UTC, Mimi Zohar wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> The -EKEYREJECTED error returned by existing is_hash_blacklisted() is
> misleading when called for checking against blacklisted hash of a
> binary.
> 
> This patch adds a wrapper function is_binary_blacklisted() to return
> -EPERM error if binary is blacklisted.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2434f7d2d488c3301ae81f1031e1c66c6f076fb7

cheers
