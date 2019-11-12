Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6056CF85F5
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 02:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKLBVE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Nov 2019 20:21:04 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfKLBVE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 11 Nov 2019 20:21:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Bqgx1Ywjz9sP4;
        Tue, 12 Nov 2019 12:21:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573521661;
        bh=F9ZI7aJXVRSlCItRZVrAQItH8rcNwZbNz7XhEYGd5MM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MoSZd7gInPCPqS8Y0iT98x1HK1vNNhVr/zZB4JiXZjLV1BMkNQT13BWWbUIqA0zBO
         JDFYy4EazB84GH1G6G2PPmoRnt0K9ChPMSxwpRYUbhePPcLg2K+M9sswNV1nyfWvTI
         Xiid+IBG0a/bOQycR7OvXIxjUmVwYErB+vS3lX5gZDZLOtkVAEdlpk1077UIzTr0z6
         GCiinP46ZWqf+B8+TrbDVVVpiaGIaZmTjGi0PuBExuFganVMoBm9VcqB6Xd+K6J74z
         TaxZH44Ms9pe5myYbyUf7AMTY7fv1Bd6UIx9AqhJkeRwsRLvKASWbtQuCphrm0eYQx
         03lK0YzT3KyTg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        George Wilson <gcwilson@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v9 0/4] powerpc: expose secure variables to the kernel and userspace
In-Reply-To: <216572e5-d8c6-f181-3ec0-b4a840f20f46@linux.microsoft.com>
References: <1573441836-3632-1-git-send-email-nayna@linux.ibm.com> <216572e5-d8c6-f181-3ec0-b4a840f20f46@linux.microsoft.com>
Date:   Tue, 12 Nov 2019 12:21:00 +1100
Message-ID: <87sgmt3n5v.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> On 11/10/19 7:10 PM, Nayna Jain wrote:
>
> Hi Nayna,
>
>> In order to verify the OS kernel on PowerNV systems, secure boot requires
>> X.509 certificates trusted by the platform. These are stored in secure
>> variables controlled by OPAL, called OPAL secure variables. In order to
>> enable users to manage the keys, the secure variables need to be exposed
>> to userspace.
> Are you planning to split the patches in this patch set into smaller 
> chunks so that it is easier to code review and also perhaps make it 
> easier when merging the changes?

I don't think splitting them would add any value. They're already split
into the firmware specific bits (patch 1), and the sysfs parts (patch
2), which is sufficient for me.

cheers
