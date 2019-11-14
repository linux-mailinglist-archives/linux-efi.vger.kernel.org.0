Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C081FC227
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 10:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKNJIM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 04:08:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56133 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfKNJIM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:12 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxy6dpQz9sSQ; Thu, 14 Nov 2019 20:08:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e14555e3d0e9edfad0a6840c0152f71aba97e793
In-Reply-To: <1572492694-6520-6-git-send-email-zohar@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v10 5/9] ima: make process_buffer_measurement() generic
Message-Id: <47DFxy6dpQz9sSQ@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:05 +1100 (AEDT)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2019-10-31 at 03:31:30 UTC, Mimi Zohar wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> process_buffer_measurement() is limited to measuring the kexec boot
> command line. This patch makes process_buffer_measurement() more
> generic, allowing it to measure other types of buffer data (e.g.
> blacklisted binary hashes or key hashes).
> 
> process_buffer_measurement() may be called directly from an IMA
> hook or as an auxiliary measurement record. In both cases the buffer
> measurement is based on policy. This patch modifies the function to
> conditionally retrieve the policy defined PCR and template for the IMA
> hook case.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> [zohar@linux.ibm.com: added comment in process_buffer_measurement()]
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e14555e3d0e9edfad0a6840c0152f71aba97e793

cheers
