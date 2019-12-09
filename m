Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D004B117763
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2019 21:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLIU07 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Dec 2019 15:26:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57152 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIU07 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Dec 2019 15:26:59 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id A5797205D07B;
        Mon,  9 Dec 2019 12:26:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5797205D07B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575923218;
        bh=kAPFAoYHjtm9AzjW0GrD+w2DDaOvexFJS3Kgd3gHBDc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AQ5uuAD8hU2knYQC4wx13g05p4OJw0EHmqdDQBc6zcen/V0HeLrkanZAx5IqIfhpQ
         0RijU2xmHfT9178jTBC8bI6uiCY4SynSPahDfBsqrEQDStuYh9OGcQOr/oa34/Ym1g
         poP8Gb4vq9AKhOt/zP1eDpBOyIrElfMQP702yn7c=
Subject: Re: [PATCH v10 0/9] powerpc: Enabling IMA arch specific secure boot
 policies
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5254346f-4ba7-c820-e127-d46b84f2e6e6@linux.microsoft.com>
Date:   Mon, 9 Dec 2019 12:27:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Mimi,

On 10/30/2019 8:31 PM, Mimi Zohar wrote:

> This patchset extends the previous version[1] by adding support for
> checking against a blacklist of binary hashes.
> 
> The IMA subsystem supports custom, built-in, arch-specific policies to
> define the files to be measured and appraised. These policies are honored
> based on priority, where arch-specific policy is the highest and custom
> is the lowest.

Has this change been signed off and merged for the next update of the 
kernel (v5.5)?

thanks,
  -lakshmi
