Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B57B2D72A7
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2019 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfJOJ7k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Oct 2019 05:59:40 -0400
Received: from ozlabs.org ([203.11.71.1]:39937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfJOJ7j (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Oct 2019 05:59:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46srWC5sZyz9sPF;
        Tue, 15 Oct 2019 20:59:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571133576;
        bh=g7FNvEmUMKUBTSEs/cnh7zM1HyCNiU5+T2IblHoqAb0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YhiIDr4gz6XDbMGr15Sc7t/zYDWa3ckmLK2XTtTmSgqqrNXBz3WCh1sI7ugcw7No9
         9z/qYOLr8MUPtAKaVi6QmsvCB+7syHLOtLjJMiLHvuVXrmdhQ4kfc4R/hxhAzoqcWc
         DXrJZVow2QCc1+8qU0s/wthBbQykITP7zxw6ctjJwt4d++rY+SWJGL4nH5dUvX9Ymv
         IlRkxldrLGRye660X7Ik8GGe+BCEWbA2Gw87Q+Xg1ydHXlKtoT1RN/BHCo0LAQcUO9
         0pu9XfAzqas4SdhbSR34cVXh+P3Yl/xhSjCSnzZYeqor9s72u1idfYI6KnZza8CMRy
         b2RE/asCPE4Nw==
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
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v7 2/8] powerpc: add support to initialize ima policy rules
In-Reply-To: <1570799579.5250.72.camel@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com> <1570497267-13672-3-git-send-email-nayna@linux.ibm.com> <1570799579.5250.72.camel@linux.ibm.com>
Date:   Tue, 15 Oct 2019 20:59:34 +1100
Message-ID: <87bluiuy61.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Mimi Zohar <zohar@linux.ibm.com> writes:
> On Mon, 2019-10-07 at 21:14 -0400, Nayna Jain wrote:
...
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index b4a221886fcf..deb19ec6ba3d 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -938,6 +938,8 @@ config PPC_SECURE_BOOT
>>  	prompt "Enable secure boot support"
>>  	bool
>>  	depends on PPC_POWERNV
>> +	depends on IMA
>> +	depends on IMA_ARCH_POLICY
>
> As IMA_ARCH_POLICY is dependent on IMA, I don't see a need for
> depending on both IMA and IMA_ARCH_POLICY.

I agree. And what we actually depend on is the arch part, so it should
depend on just IMA_ARCH_POLICY.

cheers
