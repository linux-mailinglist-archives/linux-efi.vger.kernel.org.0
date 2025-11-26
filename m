Return-Path: <linux-efi+bounces-5688-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB0BC87DF6
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 03:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6F384E21D6
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 02:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823972F618B;
	Wed, 26 Nov 2025 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Arw4/rWC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4D189F20;
	Wed, 26 Nov 2025 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125646; cv=none; b=YdL0Iq9Ik9VTQRihQw05MF4TYN6dyyDKosYNdFS+mWZcBHmGMxx/e9RaLsJhK/PUT7hKdRrgyVLWniH5T+oXmkgCHka7+nZu9h8fiO6IgZiobPbcrsz8Au1fIA8C1c7d9FgJYAqf2tMeAV7Da3gEdDQCPkp/f7Nb6V6u4uGhpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125646; c=relaxed/simple;
	bh=ejLLVGFn7fUEHutNPtwCscZRD3uu/vy6+fH9EAcaTAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lr5HXppZLJdi41Mt4EA6/YHbrhoQrM5sQE35mgBO6HjdfF7u27Xia+A1sIpKKW+rMlmgjcKTnV0nmJz906eLjHRemSfja1RQujSUaqta5JGzor1xyRP+nKzi4ArcOvYaRvMb1jnoSBz5eQZTDhwONIuDJGhdC9qZeaXsmudnahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Arw4/rWC; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764125584;
	bh=cwmHQUiktpfIe9jPsWOgiNlI4Nxy8A4DW1msOvdmXiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Arw4/rWC9AoA2khaGM7E+LPnIw+Qzi5Mb8SqIhHQA/yVfC/esowoQ4JUs0Jdl5ymo
	 EnR4M08i7ke3GVOW4NxuFzn8vNf80emgijSv0VAKWQDv3oAf5ytFhipCMHZihtW/G3
	 Pu7EM5QkHyWJ5qQ14qcpKWcq7815pwqRGdK5Z2HE=
X-QQ-mid: zesmtpsz3t1764125581t91fcaecd
X-QQ-Originating-IP: mfsAZRNMoXh2lPIXQzm05bW8CpUAHvM4VX6rncFsP1o=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 10:52:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3106249551322280944
Message-ID: <37CDF8D84A26949E+cc84e626-911b-40ac-90ef-ff5a2df585a9@uniontech.com>
Date: Wed, 26 Nov 2025 10:52:59 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/riscv: Remove the useless failure return message
 print
To: Paul Walmsley <pjw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: ardb@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251031024328.735161-1-maqianga@uniontech.com>
 <f9d632d5-22dc-8b14-8a70-37737a78f206@kernel.org>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <f9d632d5-22dc-8b14-8a70-37737a78f206@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NkdVy0O1B8HBKdGcy6k0vTTz66BlM6AXNiu1Gv93w8QUHFpI5Qorre8u
	hjH/R67FEp3Un/ud1gBs26xz9ZDpxhchEwx3C/mVQLHve7Dc9H+Q/zYPqGjLrEFWie3+4dg
	NW9+eL/DrtxY5AUpMIF2jt6pJ4QNEdhI69Wkk8HvGRdTnrvhwaklRUvUgvvJzCz/NXSzlVD
	GEvF3RWgSZuhJ3SUBfbwTVJjEFWc1dVyY8jIG494np3iGE+IDfeavjMd2PH4xjhmW3EZszn
	RX+aLPFhC3d169zL479FDcgkT+ZMH1Kmvxtz0+2ZQqNB4UVCTFoM6HCRtIlYTbxG1lZoWYd
	tEefmWkHhpwISAMjUoCmmnTS3Q5wKrYOMGLrb/NsrJykhBMACYd37ri1GV/+qJnazcrZEBg
	MVqeGBoAb2fKfPqGzYqfV/+jMLUemRtAqL4M6RjUSvAfeTHA7dmtt6BO6aCyjDoqA1UTGeW
	Q3Mi/19Exjb59yPj1mSY318hKzdI+O4u8oWl0RaFm9Q/8TcROTjfuBzo28WWHb72Z0reuDh
	Hbj26hZ4CuHH69kP/0484G8bSZMcGUMM8ULIFUspNejmUobS7CrYdkD2GNp0HFdfb4aqFYc
	4GeHBw7JQ/fBicN4kaAWRgIWqlGy85YcHoxUJsk1zMQgHpMIzCJumNCPrIfvo9KXCN6JuvV
	wH+QVl2Sh54n+2buszTdzpKS8SmVIcrBoPSifmBJyn0Nr2OaI+jRF6irl+hxGXoB1+8Q9xO
	GsFVO+3JmIpTkoLFOfrIH77NjknOsqGaRTlgOvMHmUFsZaQifCjPMbcVOSytocJHYIag4dh
	Azcm0tvZKvfSeA8Tq7yy0DErbzhggmlJm6jpvdqCoCDtY/1sqKiCtB984BdSSk08nwv2O9y
	P+nshudjEkSAamQlDJsrlfrUUBztYcvQN963m30ShcDyXvVqrbqKJr5QtYHHlhJxln3KaV9
	WhvE48ujXSvAlVD75CrZPsW9z9G3KkNI03hS3CqcTB44xQbvINCVsg/LLUOIg88gusetHaV
	JH6q5bYuRdBoaUjFDyBB0QFhTxTy32PHwRDqm2Ru2y4BGVYoMuJuXV+7ctqWMka2a8lPikJ
	oTMgpe3xfndhQjhle5kGwI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0


在 2025/11/26 08:27, Paul Walmsley 写道:
> On Fri, 31 Oct 2025, Qiang Ma wrote:
>
>> In the efi_create_mapping() in arch/riscv/kernel/efi.c,
>> the return value is always 0, and this debug message
>> is unnecessary. So, remove it.
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> Considering that Ard doesn't think efi_create_mapping() should be changed
> to remove the return value, and that the ARM version of this code retains
> the debug message, we should probably keep things the way they are.  But
> if you can get a Reviewed-by: or an Acked-by: from Ard, I'd take it.
Hi, Ard, what are your suggestions for this patch?

Could you add a Reviewed-by: or an Acked-by: to this patch?
>
>
> Thanks for your patch,
>
> - Paul
>
>


