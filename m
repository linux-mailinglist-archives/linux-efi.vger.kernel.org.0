Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD20E3A32
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2019 19:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503806AbfJXRim (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Oct 2019 13:38:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59044 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfJXRim (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Oct 2019 13:38:42 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id B1CC720F3BC1;
        Thu, 24 Oct 2019 10:38:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1CC720F3BC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571938721;
        bh=jAzro5QgHA6OVAS90ZdpCnam0CrEJTVosK5szwE7n2M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HAKr74f1Pnx9P2V2H2BkmgTxZjOt5gAvytgB5Le7ZERFnMBkqlNi3+aE2tlopHu2o
         krpKOkiXFKct7xn4poUOKA7ReFKVdM5B3EFPFge3MvteTnsq5mtwaKzp4vG//bbwCw
         AwWin41kd2m6SnBRGcbiEhbML+3+4SHCH2WceUf4=
Subject: Re: [PATCH v9 3/8] powerpc: detect the trusted boot state of the
 system
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
 <20191024034717.70552-4-nayna@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <d713ae8c-7223-b3f3-999b-0c9076733c17@linux.microsoft.com>
Date:   Thu, 24 Oct 2019 10:38:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024034717.70552-4-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/23/2019 8:47 PM, Nayna Jain wrote:

> +bool is_ppc_trustedboot_enabled(void)
> +{
> +	struct device_node *node;
> +	bool enabled = false;
> +
> +	node = get_ppc_fw_sb_node();
> +	enabled = of_property_read_bool(node, "trusted-enabled");

Can get_ppc_fw_sb_node return NULL?
Would of_property_read_bool handle the case when node is NULL?

  -lakshmi
