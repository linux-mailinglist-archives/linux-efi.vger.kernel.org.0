Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE7CA991B
	for <lists+linux-efi@lfdr.de>; Thu,  5 Sep 2019 05:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfIED7g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 4 Sep 2019 23:59:36 -0400
Received: from ozlabs.org ([203.11.71.1]:52957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfIED7g (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Sep 2019 23:59:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46P6QF30c0z9s7T;
        Thu,  5 Sep 2019 13:59:33 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
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
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 3/4] x86/efi: move common keyring handler functions to new file
In-Reply-To: <1567551071.4937.5.camel@linux.ibm.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com> <1566825818-9731-4-git-send-email-nayna@linux.ibm.com> <87pnkisyiv.fsf@mpe.ellerman.id.au> <1567551071.4937.5.camel@linux.ibm.com>
Date:   Thu, 05 Sep 2019 13:59:33 +1000
Message-ID: <87blvzpf4q.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Mimi Zohar <zohar@linux.ibm.com> writes:
> (Cc'ing Josh Boyer, David Howells)
>
> On Mon, 2019-09-02 at 21:55 +1000, Michael Ellerman wrote:
>> Nayna Jain <nayna@linux.ibm.com> writes:
>> 
>> > The handlers to add the keys to the .platform keyring and blacklisted
>> > hashes to the .blacklist keyring is common for both the uefi and powerpc
>> > mechanisms of loading the keys/hashes from the firmware.
>> >
>> > This patch moves the common code from load_uefi.c to keyring_handler.c
>> >
>> > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
>
>> > ---
>> >  security/integrity/Makefile                   |  3 +-
>> >  .../platform_certs/keyring_handler.c          | 80 +++++++++++++++++++
>> >  .../platform_certs/keyring_handler.h          | 32 ++++++++
>> >  security/integrity/platform_certs/load_uefi.c | 67 +---------------
>> >  4 files changed, 115 insertions(+), 67 deletions(-)
>> >  create mode 100644 security/integrity/platform_certs/keyring_handler.c
>> >  create mode 100644 security/integrity/platform_certs/keyring_handler.h
>> 
>> This has no acks from security folks, though I'm not really clear on who
>> maintains those files.
>
> I upstreamed David's, Josh's, and Nayna's patches, so that's probably
> me.
>
>> Do I take it because it's mostly just code movement people are OK with
>> it going in via the powerpc tree?
>
> Yes, the only reason for splitting load_uefi.c is for powerpc.  These
> patches should be upstreamed together.  

Thanks.

cheers
