Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088DADDF68
	for <lists+linux-efi@lfdr.de>; Sun, 20 Oct 2019 18:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfJTQJF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Oct 2019 12:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfJTQJF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 20 Oct 2019 12:09:05 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAB83218BA;
        Sun, 20 Oct 2019 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571587744;
        bh=2rqZqTghk0jq/6poDX1vz2pfYzf7Qp8iUns4NuEy5NQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HZkr9mE9kNuZvNX5TVBK80qFqOhhKOI6Vd4XPcDsexisoiZQIUZLZ/LAj/FksDrGR
         bgMOem4aYqutYg8IUTz77yWm6QiAJnF4ImF78HC7TIBhqG66WXDFG2MSG0pQ0AA/ea
         uVPisOxbE+dqQv9ilAzF5wVw96sXtT4B8LpkVHCY=
Message-ID: <1571587740.5104.10.camel@kernel.org>
Subject: Re: [PATCH v8 7/8] ima: check against blacklisted hashes for files
 with modsig
From:   Mimi Zohar <zohar@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Sun, 20 Oct 2019 12:09:00 -0400
In-Reply-To: <1571587602.5104.8.camel@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
         <1571508377-23603-8-git-send-email-nayna@linux.ibm.com>
         <1571587602.5104.8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2019-10-20 at 12:06 -0400, Mimi Zohar wrote:
> On Sat, 2019-10-19 at 14:06 -0400, Nayna Jain wrote:
> > Asymmetric private keys are used to sign multiple files. The kernel
> > currently support checking against blacklisted keys. However, if the
> > public key is blacklisted, any file signed by the blacklisted key will
> > automatically fail signature verification. We might not want to blacklist
> > all the files signed by a particular key, but just a single file.
> > Blacklisting the public key is not fine enough granularity.
> > 
> > This patch adds support for checking against the blacklisted hash of the
> > file based on the IMA policy. The blacklisted hash is the file hash
> > without the appended signature. Defined is a new policy option
> > "appraise_flag=check_blacklist".
> 
> Please add an example of how to blacklist a file with an appended
> signature.  The simplest example that works on x86 as well as Power
> would be blacklisting a kernel module.  The example should include
> calculating the kernel module hash without the appended signature,
> enabling the Kconfig option (CONFIG_SYSTEM_BLACKLIST_HASH_LIST), and
> the blacklist hash format (eg. "bin:<file hash>").

And of course, the IMA appraise kernel module policy rule containing
"appraise_flag=check_blacklist".

thanks,

Mimi
