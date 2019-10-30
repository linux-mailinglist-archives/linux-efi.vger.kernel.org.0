Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6FE9EC5
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2019 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJ3PWH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Oct 2019 11:22:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50360 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3PWH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Oct 2019 11:22:07 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2F1F320B7192;
        Wed, 30 Oct 2019 08:22:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F1F320B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572448926;
        bh=aR94NnmP7TKVuROo6fBFHQ4znnOThB6fX3h7dOkbufA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZJ9rAE+/d1St7e1pDxUMWGbthM4vxv2cUGOf8lV1whWRuzTEeIF2VjLIT2MaHIatI
         1H1qiVfMWqnYbWg1GL2xquZ5Ym5kaKGCyg/A1YWCuqVhxYV2q+gi7/1BPMabY4+qqU
         SbV1uefOMu1rpItfoomXsleeU2H8a42/ZYIAhRK8=
Subject: Re: [PATCH v9 5/8] ima: make process_buffer_measurement() generic
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
 <20191024034717.70552-6-nayna@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6c94bfc0-d3ce-202b-6927-f664ee513fa9@linux.microsoft.com>
Date:   Wed, 30 Oct 2019 08:22:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024034717.70552-6-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/23/19 8:47 PM, Nayna Jain wrote:

Hi Nayna,

> process_buffer_measurement() is limited to measuring the kexec boot
> command line. This patch makes process_buffer_measurement() more
> generic, allowing it to measure other types of buffer data (e.g.
> blacklisted binary hashes or key hashes).

Now that process_buffer_measurement() is being made generic to measure 
any buffer, it would be good to add a tag to indicate what type of 
buffer is being measured.

For example, if the buffer is kexec command line the log could look like:

  "kexec_cmdline: <command line data>"

Similarly, if the buffer is blacklisted binary hash:

  "blacklist hash: <data>".

If the buffer is key hash:

  "<name of the keyring>: key data".

This would greatly help the consumer of the IMA log to know the type of 
data represented in each IMA log entry.

thanks,
  -lakshmi
